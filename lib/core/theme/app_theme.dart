import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF1F2937), // Slate
      onPrimary: Colors.white,
      secondary: Color(0xFF10B981), // Mint
      onSecondary: Colors.black,
      tertiary: Color(0xFF2563EB), // Blue
      onTertiary: Colors.white,
      error: Color(0xFFEF4444),
      onError: Colors.white,
      background: Color(0xFF0F172A),
      onBackground: Colors.white,
      surface: Color(0xFF1F2937),
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F2937),
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF10B981), // Cor secundária (Mint)
        foregroundColor: Colors.black, // Cor do texto
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white70, // Cor do texto
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      side: BorderSide(color: Colors.grey.shade400, width: 2),
      checkColor: MaterialStateProperty.all(Colors.black),
      fillColor: MaterialStateProperty.all(const Color(0xFF10B981)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      labelStyle: TextStyle(color: Colors.grey.shade400),
    ),
  );
}