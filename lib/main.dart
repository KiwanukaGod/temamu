import 'package:flutter/material.dart';
// Import your screens here - adjust paths based on your folder structure
import 'features/auth/screens/splash_screen.dart';
import 'features/auth/screens/sign_up_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/home_screen.dart';
import 'core/services/otp_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const TemamuApp());
}

class TemamuApp extends StatelessWidget {
  const TemamuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temamu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // 1. The app starts at the Splash Screen
      initialRoute: '/', 
      
      // 2. This is the "Map" the error was looking for
      routes: {
        '/': (context) => const SplashScreen(),
        '/sign-up': (context) => const SignUpScreen(),
        '/otp': (context) => const OtpScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}