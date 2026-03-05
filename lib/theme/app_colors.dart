import 'package:flutter/material.dart';

class AppColors {
  // ===== Brand Palette (from your image) =====
  static const Color navy = Color(0xFF0F2854); // #0F2854
  static const Color royal = Color(0xFF1C4D8D); // #1C4D8D
  static const Color sky = Color(0xFF4988C4); // #4988C4
  static const Color ice = Color(0xFFBDE8F5); // #BDE8F5

  // ===== Light Theme =====
  // Choose royal as your primary brand color for readability on light surfaces.
  static const Color lightPrimary = royal;
  static const Color lightSecondary = sky;
  static const Color lightTertiary = ice;

  // Backgrounds & surfaces
  static const Color lightBackground = Color(
    0xFFF7FCFF,
  ); // very light blue-white
  static const Color lightSurface = Colors.white;

  // Text
  static const Color lightTextPrimary = navy;
  static const Color lightTextSecondary = Color(0xFF375A7A); // muted blue-gray

  // Semantic
  static const Color lightSuccess = Color(0xFF16A34A);
  static const Color lightWarning = Color(0xFFF59E0B);
  static const Color lightError = Color(0xFFEF4444);

  // ===== Dark Theme =====
  // Keep navy background and use ice/sky for readable accents.
  static const Color darkPrimary = sky;
  static const Color darkSecondary = ice;
  static const Color darkTertiary = royal;

  static const Color darkBackground = Color.fromARGB(255, 8, 23, 48);
  static const Color darkSurface = Color(
    0xFF132F63,
  ); // slightly lighter than navy

  static const Color darkTextPrimary = Color(
    0xFFEAF2FF,
  ); // off-white with blue tint
  static const Color darkTextSecondary = Color(0xFFB8CBE6);

  static const Color darkSuccess = Color(0xFF22C55E);
  static const Color darkWarning = Color(0xFFFBBF24);
  static const Color darkError = Color(0xFFF87171);

  // ===== Splash (match your splash assets) =====
  // You can keep these as-is or adjust later; these are safe defaults.
  static const Color splashLightTop = lightBackground;
  static const Color splashLightBottom = ice;

  static const Color splashDarkTop = navy;
  static const Color splashDarkBottom = darkSurface;
}
