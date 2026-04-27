import 'package:flutter/material.dart';
import 'package:temamu/core/services/session_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2)); // Show logo for a bit
    final valid = await SessionService.isSessionValid();
    final hasStoredProfile = await SessionService.hasStoredProfile();

    if (!mounted) {
      return;
    }

    if (valid) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (hasStoredProfile) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, '/sign-up');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF2563EB),
      body: Center(
        child: Text(
          "TEMAMU",
          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 4),
        ),
      ),
    );
  }
}
