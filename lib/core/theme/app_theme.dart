import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.aliceBlue,
      surfaceContainerHighest: AppColors.lightSurface,
      onSurface: AppColors.richBlack,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.aliceBlue,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.primary, foregroundColor: Colors.white, elevation: 0),
    cardColor: AppColors.lightSurface,
    textTheme: const TextTheme(
      headlineLarge: AppTextStyles.headlineLarge,
      titleMedium: AppTextStyles.titleMedium,
      bodyMedium: AppTextStyles.bodyMedium,
    ).apply(bodyColor: AppColors.lightText, displayColor: AppColors.lightText),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.richBlack,
      surfaceContainerHighest: AppColors.darkSurface,
      onSurface: AppColors.aliceBlue,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.richBlack,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.prussianBlue, foregroundColor: AppColors.aliceBlue, elevation: 0),
    cardColor: AppColors.darkSurface,
    textTheme: const TextTheme(
      headlineLarge: AppTextStyles.headlineLarge,
      titleMedium: AppTextStyles.titleMedium,
      bodyMedium: AppTextStyles.bodyMedium,
    ).apply(bodyColor: AppColors.darkText, displayColor: AppColors.darkText),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.secondary, foregroundColor: AppColors.richBlack),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.prussianBlue,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.secondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.secondary, width: 2),
      ),
    ),
  );
}
