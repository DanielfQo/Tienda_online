import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData vibrantTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFF5D3FD3), // morado brillante
    primaryColor: const Color(0xFFFBDE7E), // amarillo suave
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFFBDE7E),
      secondary: Color(0xFFFFB6C1),
      background: Color(0xFF5D3FD3),
      surface: Colors.white,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onBackground: Colors.white,
      onSurface: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF4A30B3),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    cardColor: const Color(0xFFECE6F5),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Color(0xFFFBDE7E),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
