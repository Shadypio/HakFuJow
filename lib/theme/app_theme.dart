import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFC62828);
  static const Color secondary = Color(0xFF212121);
  static const Color background = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF1A1A1A);
  static const Color cardColor = Colors.white;

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        secondary: secondary,
        surface: background,
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(color: Colors.grey),
      ),
    );
  }
}
