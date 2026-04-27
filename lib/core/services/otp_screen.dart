import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temamu/core/services/auth_service.dart';
import 'package:temamu/core/services/session_service.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const int _otpLength = 6;
  final List<TextEditingController> _controllers = List.generate(
    _otpLength,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    _otpLength,
    (_) => FocusNode(),
  );
  bool _didLoadArguments = false;
  bool _isVerifying = false;
  bool _isResending = false;
  String? _verificationId;
  String? _phone;
  String? _name;
  int? _resendToken;

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_didLoadArguments) {
      return;
    }

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      _verificationId = args['verificationId'] as String?;
      _phone = args['phone'] as String?;
      _name = args['name'] as String?;
      _resendToken = args['resendToken'] as int?;
    }

    _didLoadArguments = true;
  }

  Future<void> _verifyAndProceed() async {
    final verificationId = _verificationId;
    final phone = _phone;

    if (verificationId == null || phone == null) {
      _showMessage('Missing verification details. Please request a new code.');
      return;
    }

    final otp = _controllers.map((controller) => controller.text).join();

    if (otp.length != _otpLength) {
      _showMessage('Please enter the full 6-digit code.');
      return;
    }

    setState(() => _isVerifying = true);

    try {
      final userCredential = await AuthService.verifyOtp(
        verificationId: verificationId,
        smsCode: otp,
      );

      await SessionService.saveUserSession(
        name: _name,
        phone: userCredential.user?.phoneNumber ?? phone,
      );

      if (!mounted) {
        return;
      }

      setState(() => _isVerifying = false);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } on FormatException catch (exception) {
      if (!mounted) {
        return;
      }

      setState(() => _isVerifying = false);
      _showMessage(exception.message);
    } on FirebaseAuthException catch (exception) {
      if (!mounted) {
        return;
      }

      setState(() => _isVerifying = false);
      _showMessage(exception.message ?? 'Could not verify the code.');
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() => _isVerifying = false);
      _showMessage('Something went wrong while verifying the code.');
    }
  }

  Future<void> _resendCode() async {
    final phone = _phone;
    if (phone == null) {
      _showMessage('Missing phone number. Please start again.');
      return;
    }

    setState(() => _isResending = true);

    try {
      await AuthService.sendOtp(
        phoneNumber: phone,
        forceResendingToken: _resendToken,
        onAutoVerified: (userCredential, normalizedPhone) async {
          await SessionService.saveUserSession(
            name: _name,
            phone: userCredential.user?.phoneNumber ?? normalizedPhone,
          );

          if (!mounted) {
            return;
          }

          setState(() => _isResending = false);
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        },
        onCodeSent: (verificationId, resendToken, normalizedPhone) {
          if (!mounted) {
            return;
          }

          setState(() {
            _verificationId = verificationId;
            _resendToken = resendToken;
            _phone = normalizedPhone;
            _isResending = false;
          });
          _clearOtpFields();
          _showMessage('A new verification code has been sent.');
        },
        onVerificationFailed: (exception) {
          if (!mounted) {
            return;
          }

          setState(() => _isResending = false);
          _showMessage(exception.message ?? 'Failed to resend the code.');
        },
        onCodeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
      );
    } on FormatException catch (exception) {
      if (!mounted) {
        return;
      }

      setState(() => _isResending = false);
      _showMessage(exception.message);
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() => _isResending = false);
      _showMessage('Something went wrong while resending the code.');
    }
  }

  void _clearOtpFields() {
    for (final controller in _controllers) {
      controller.clear();
    }

    if (_focusNodes.isNotEmpty) {
      _focusNodes.first.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_didLoadArguments || _verificationId == null || _phone == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Verification details are missing. Please go back and request a new code.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white, iconTheme: const IconThemeData(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Text("Verify Phone", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(
              "Enter the 6-digit code sent to\n$_phone",
              textAlign: TextAlign.center, 
              style: const TextStyle(color: Colors.grey, height: 1.5)
            ),
            const SizedBox(height: 48),
            
            // --- INTERACTIVE OTP BOXES ---
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: List.generate(_otpLength, _buildOtpInput),
            ),
            
            const SizedBox(height: 48),
            
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: _isVerifying ? null : _verifyAndProceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _isVerifying
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text("Verify & Start", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            
            TextButton(
              onPressed: _isResending ? null : _resendCode,
              child: Text(
                _isResending ? "Resending..." : "Resend Code",
                style: const TextStyle(color: Color(0xFF2563EB)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // This creates a single interactive digit box
  Widget _buildOtpInput(int index) {
    return SizedBox(
      width: 48,
      height: 64,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        textInputAction: index == _otpLength - 1
            ? TextInputAction.done
            : TextInputAction.next,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: "", // Hide the 0/1 counter
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < _otpLength - 1) {
            // Move focus to the next box automatically
            _focusNodes[index + 1].requestFocus();
          } else if (value.isNotEmpty && index == _otpLength - 1) {
            _focusNodes[index].unfocus();
          } else if (value.isEmpty && index > 0) {
            // Move back if they delete
            _focusNodes[index - 1].requestFocus();
          }
        },
        onSubmitted: (_) {
          if (index == _otpLength - 1 && !_isVerifying) {
            _verifyAndProceed();
          }
        },
      ),
    );
  }
}
