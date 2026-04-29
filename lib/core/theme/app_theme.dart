import 'package:flutter/material.dart';

class TemamuTheme {
  // Brand Colors
  static const Color actionBlue = Color(0xFF2563EB);
  static const Color cyan = Color(0xFF06B6D4);
  static const Color slateNavy = Color(0xFF1E293B);
  static const Color backgroundLight = Color(
    0xFFF8FAFC,
  ); // Light grayish-white for contrast

  static ThemeData get theme {
    return ThemeData(
      primaryColor: actionBlue,
      scaffoldBackgroundColor: backgroundLight,
      fontFamily: 'Inter', // Or your preferred sans-serif font
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundLight,
        elevation: 0,
        iconTheme: IconThemeData(color: slateNavy),
        titleTextStyle: TextStyle(
          color: slateNavy,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: actionBlue,
          foregroundColor: Colors.white,
          elevation: 2, // Keeping it light
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
