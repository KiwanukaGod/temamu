import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart'; // Required for Firestore/Auth
import 'features/auth/screens/splash_screen.dart';
import 'features/auth/screens/login_screen.dart'; 

void main() async {
  // 1. Ensures Flutter is ready to call native code (like Firebase)
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Connects your app to your Firebase project
  // Note: You must run the 'flutterfire configure' command in your terminal first!
  // await Firebase.initializeApp();

  runApp(const TemamuApp());
}

class TemamuApp extends StatelessWidget {
  const TemamuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temamu',
      debugShowCheckedModeBanner: false, // Hides that red 'Debug' banner
      
      // 3. Define the Global Fintech Theme
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF2563EB), // Deep Blue
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          secondary: const Color(0xFF06B6D4), // Soft Cyan
          surface: Colors.white,
        ),
        // Modern Typography (Using Inter or system sans-serif)
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
          bodyLarge: TextStyle(color: Color(0xFF334155)),
        ),
      ),

      // 4. Set the initial screen
      home: const SplashScreen(),
      
      // 5. Future-proofing with Routes
      // This is where you will list your Home and Login screens later
      routes: {
        '/login': (context) => const Placeholder(), // Temporary placeholder
        '/home': (context) => const Placeholder(),
      },
    );
  }
}

