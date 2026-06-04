import 'package:flutter/material.dart';

/// app colour plate
class AppColors {
  static const Color primary = Colors.blue;
  static const Color darkBackground = Color(0xFF121212);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color cardDark = Color(0xFF1E1E1E);
}

/// Theme Configuration
class AppTheme {
  /// Light Theme
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  );

  /// Dark Theme
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      surface: AppColors.cardDark,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.cardDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.cardDark,
      elevation: 0,
    ),
  );
}

/// Theme Notifier
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
