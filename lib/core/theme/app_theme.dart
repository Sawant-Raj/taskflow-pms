import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Color(0xFF4682B4),
    scaffoldBackgroundColor: Colors.grey.shade100,

    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,

      backgroundColor: const Color(0xFF4682B4),
      foregroundColor: Colors.white,

      surfaceTintColor: Colors.transparent,

      titleTextStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 0.2,
      ),

      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 24,
      ),

      actionsIconTheme: const IconThemeData(
        color: Colors.white,
        size: 22,
      ),
    ),

    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),

        disabledBackgroundColor: Color(0xFF4682B4),
        disabledForegroundColor: Colors.white70,
      ),
    ),

    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.fixed),
  );
}
