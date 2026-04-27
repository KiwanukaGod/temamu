import 'package:flutter/material.dart';
import 'package:temamu/core/services/auth_service.dart';
import 'package:temamu/core/services/session_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isSavingProfile = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _createProfile() async {
    final name = _nameController.text.trim();
    final phoneInput = _phoneController.text.trim();

    if (name.isEmpty) {
      _showMessage('Enter your full name before continuing.');
      return;
    }

    if (phoneInput.isEmpty) {
      _showMessage('Enter your phone number before continuing.');
      return;
    }

    setState(() => _isSavingProfile = true);

    try {
      final normalizedPhone = AuthService.normalizePhoneNumber(phoneInput);
      await SessionService.saveUserProfile(name: name, phone: normalizedPhone);
      await SessionService.saveUserSession(
        name: name,
        phone: normalizedPhone,
      );

      if (!mounted) {
        return;
      }

      setState(() => _isSavingProfile = false);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } on FormatException catch (exception) {
      if (!mounted) {
        return;
      }

      setState(() => _isSavingProfile = false);
      _showMessage(exception.message);
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() => _isSavingProfile = false);
      _showMessage('Something went wrong while saving your profile.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create Account", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Full Name", prefixIcon: Icon(Icons.person_outline)),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Phone Number", prefixIcon: Icon(Icons.phone_android)),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isSavingProfile ? null : _createProfile,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB)),
                child: _isSavingProfile
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                child: const Text("Already have an account? Login", style: TextStyle(color: Color(0xFF2563EB))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
