import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String normalizePhoneNumber(String input) {
    final compact = input.replaceAll(RegExp(r'[^0-9+]'), '');

    if (compact.isEmpty) {
      throw const FormatException('Enter your phone number.');
    }

    if (compact.startsWith('+')) {
      return _validatePhoneNumber(compact);
    }

    if (compact.startsWith('0')) {
      return _validatePhoneNumber('+256${compact.substring(1)}');
    }

    if (compact.startsWith('256')) {
      return _validatePhoneNumber('+$compact');
    }

    return _validatePhoneNumber('+256$compact');
  }

  static Future<void> sendOtp({
    required String phoneNumber,
    int? forceResendingToken,
    required Future<void> Function(UserCredential userCredential, String phone)
    onAutoVerified,
    required void Function(
      String verificationId,
      int? resendToken,
      String phone,
    )
    onCodeSent,
    required void Function(FirebaseAuthException exception)
    onVerificationFailed,
    required void Function(String verificationId) onCodeAutoRetrievalTimeout,
  }) async {
    final normalizedPhone = normalizePhoneNumber(phoneNumber);

    await _auth.verifyPhoneNumber(
      phoneNumber: normalizedPhone,
      forceResendingToken: forceResendingToken,
      verificationCompleted: (credential) async {
        try {
          final userCredential = await _auth.signInWithCredential(credential);
          await onAutoVerified(userCredential, normalizedPhone);
        } on FirebaseAuthException catch (exception) {
          onVerificationFailed(exception);
        }
      },
      verificationFailed: onVerificationFailed,
      codeSent: (verificationId, resendToken) {
        onCodeSent(verificationId, resendToken, normalizedPhone);
      },
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
    );
  }

  static Future<UserCredential> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    final normalizedCode = smsCode.replaceAll(RegExp(r'\D'), '');

    if (normalizedCode.length != 6) {
      throw const FormatException('Enter the full 6-digit verification code.');
    }

    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: normalizedCode,
    );

    return _auth.signInWithCredential(credential);
  }

  static String _validatePhoneNumber(String phoneNumber) {
    final isValid = RegExp(r'^\+\d{10,15}$').hasMatch(phoneNumber);

    if (!isValid) {
      throw const FormatException(
        'Enter a valid phone number, for example 07XXXXXXXX.',
      );
    }

    return phoneNumber;
  }
}
