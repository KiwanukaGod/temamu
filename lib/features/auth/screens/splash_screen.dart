import 'dart:async'; // Fix 1: Adds the Timer capability
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Fix 2: Links to your login file

// Fix 3: Changed 'StatelessWidget' to 'StatefulWidget'
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 1. The Gradient Background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2563EB), // Deep Blue
              Color(0xFF06B6D4), // Soft Cyan
            ],
          ),
        ),
        child: Stack(
          children: [
            // 2. Supporting Visual Element (Abstract Wave)
            // We use an Opacity widget to keep it "barely visible"
            Positioned(
              bottom: -50,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.1,
                child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 200),
                  painter: WavePainter(),
                ),
              ),
            ),
            
            // 3. Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),
                  
                  // Logo Text
                  Text(
                    'Temamu',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: Colors.cyanAccent.withOpacity(0.3),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Minimalist Icon (Three nodes/arrow)
                  const Icon(
                    Icons.account_tree_outlined, // Placeholder for your custom asset
                    color: Colors.white,
                    size: 32,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Tagline
                  Text(
                    'Split & pay bills together',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.8),
                      letterSpacing: 0.5,
                    ),
                  ),
                  
                  const Spacer(flex: 2),
                  
                  // 4. Bottom Area (Loading)
                  const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF06B6D4)),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Simple Painter for the abstract wave background
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    var path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width, size.height * 0.8);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}