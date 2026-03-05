import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.lightPrimary,
      onPrimary: Colors.white,

      secondary: AppColors.lightSecondary,
      onSecondary: Colors.white,

      tertiary: AppColors.lightTertiary,
      onTertiary: AppColors.navy,

      error: AppColors.lightError,
      onError: Colors.white,

      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,

      // A nice container tone for selected tabs/chips/etc
      primaryContainer: AppColors.ice,
      onPrimaryContainer: AppColors.navy,

      secondaryContainer: Color(0xFFD6ECFB),
      onSecondaryContainer: AppColors.navy,
    ),

    cardColor: AppColors.lightSurface,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      foregroundColor: AppColors.lightTextPrimary,
      elevation: 0,
      centerTitle: false,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightTextPrimary),
      bodyMedium: TextStyle(color: AppColors.lightTextSecondary),
      titleLarge: TextStyle(
        color: AppColors.lightTextPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.navy,

      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.navy,

      tertiary: AppColors.darkTertiary,
      onTertiary: Colors.white,

      error: AppColors.darkError,
      onError: AppColors.navy,

      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,

      primaryContainer: Color(0xFF1B3F79),
      onPrimaryContainer: AppColors.darkTextPrimary,

      secondaryContainer: Color(0xFF214A86),
      onSecondaryContainer: AppColors.darkTextPrimary,
    ),

    cardColor: AppColors.darkSurface,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 0,
      centerTitle: false,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
      titleLarge: TextStyle(
        color: AppColors.darkTextPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
