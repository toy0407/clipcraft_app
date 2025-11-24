import 'package:flutter/material.dart';

class AppColors {
  // Core Brand Colors
  static const Color primary = Color(0xFF0A80FF); // Azure
  static const Color secondary = Color(0xFF7DDE92); // Light Green

  // Supporting Colors
  static const Color prussianBlue = Color(0xFF003554);
  static const Color richBlack = Color(0xFF051923);
  static const Color aliceBlue = Color(0xFFE8F3FF);
  static const Color purple = Color(0xFF9C66D6);

  // Semantic Colors
  static const Color error = Color(0xFFFF4D4D);
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFFFC107);

  // Light Theme
  static const Color lightBackground = aliceBlue;
  static const Color lightSurface = Colors.white;
  static const Color lightText = richBlack;

  // Dark Theme
  static const Color darkBackground = richBlack;
  static const Color darkSurface = prussianBlue;
  static const Color darkText = aliceBlue;
}
