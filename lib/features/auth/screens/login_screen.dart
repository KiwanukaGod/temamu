import 'package:flutter/material.dart';
import 'package:temamu/core/services/auth_service.dart';
import 'package:temamu/core/services/session_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isSendingCode = false;

  @override
  void initState() {
    super.initState();
    _loadSavedPhoneNumber();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedPhoneNumber() async {
    final savedPhone = await SessionService.getUserPhone();
    if (!mounted || savedPhone == null) {
      return;
    }

    _phoneController.text = savedPhone;
  }

  Future<void> _requestVerificationCode() async {
    final phoneInput = _phoneController.text.trim();

    if (phoneInput.isEmpty) {
      _showMessage('Enter your phone number before continuing.');
      return;
    }

    setState(() => _isSendingCode = true);

    try {
      await AuthService.sendOtp(
        phoneNumber: phoneInput,
        onAutoVerified: (userCredential, phone) async {
          await SessionService.saveUserSession(phone: phone);

          if (!mounted) {
            return;
          }

          setState(() => _isSendingCode = false);
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        },
        onCodeSent: (verificationId, resendToken, phone) {
          if (!mounted) {
            return;
          }

          setState(() => _isSendingCode = false);
          Navigator.pushNamed(
            context,
            '/otp',
            arguments: {
              'verificationId': verificationId,
              'resendToken': resendToken,
              'phone': phone,
              'name': null,
            },
          );
        },
        onVerificationFailed: (exception) {
          if (!mounted) {
            return;
          }

          setState(() => _isSendingCode = false);
          _showMessage(exception.message ?? 'Failed to send the verification code.');
        },
        onCodeAutoRetrievalTimeout: (_) {},
      );
    } on FormatException catch (exception) {
      if (!mounted) {
        return;
      }

      setState(() => _isSendingCode = false);
      _showMessage(exception.message);
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() => _isSendingCode = false);
      _showMessage('Something went wrong while starting verification.');
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
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                prefixIcon: Icon(Icons.phone_android),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isSendingCode ? null : _requestVerificationCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                ),
                child: _isSendingCode
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        "Get Verification Code",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/sign-up'),
                child: const Text(
                  "New here? Create an Account",
                  style: TextStyle(color: Color(0xFF2563EB)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
