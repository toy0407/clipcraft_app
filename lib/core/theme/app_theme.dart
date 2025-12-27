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
      surface: AppColors.lightBackground,
      surfaceContainerHighest: AppColors.lightSurface,
      onSurface: AppColors.lightText,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.primary, foregroundColor: Colors.white, elevation: 0),
    cardColor: AppColors.lightSurface,
    textTheme: TextTheme(
      headlineLarge: AppTextStyles.headlineLarge,
      titleMedium: AppTextStyles.titleMedium,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.lightText.withValues(alpha: 0.7)),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.lightText.withValues(alpha: 0.6)),
      labelSmall: AppTextStyles.labelSmall,
      titleLarge: AppTextStyles.titleLarge,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        elevation: 4,
        shadowColor: AppColors.primary.withValues(alpha: 0.3),
      ),
    ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStatePropertyAll(AppColors.lightSurface),
      elevation: const WidgetStatePropertyAll(0),
      surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      textStyle: WidgetStatePropertyAll(AppTextStyles.bodyLarge.copyWith(color: AppColors.lightText)),
      hintStyle: WidgetStatePropertyAll(AppTextStyles.bodyMedium.copyWith(color: AppColors.lightText.withValues(alpha: 0.6))),
      overlayColor: WidgetStatePropertyAll(AppColors.primary.withValues(alpha: 0.08)),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.lightText.withValues(alpha: 0.7),
      labelStyle: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700),
      unselectedLabelStyle: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(AppColors.primary.withValues(alpha: 0.08)),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.darkBackground,
      surfaceContainerHighest: AppColors.darkSurface,
      onSurface: AppColors.darkText,
      onPrimary: AppColors.darkText,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.darkSurface, foregroundColor: Colors.white, elevation: 0),
    cardColor: AppColors.darkSurface,
    textTheme: TextTheme(
      headlineLarge: AppTextStyles.headlineLarge,
      titleMedium: AppTextStyles.titleMedium,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.darkText.withValues(alpha: 0.7)),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.darkText.withValues(alpha: 0.6)),
      labelSmall: AppTextStyles.labelSmall,
      titleLarge: AppTextStyles.titleLarge,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primaryDark, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        elevation: 4,
        shadowColor: AppColors.primary.withValues(alpha: 0.4),
      ),
    ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStatePropertyAll(AppColors.darkSurface),
      elevation: const WidgetStatePropertyAll(0),
      surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      textStyle: WidgetStatePropertyAll(AppTextStyles.bodyLarge.copyWith(color: AppColors.darkText)),
      hintStyle: WidgetStatePropertyAll(AppTextStyles.bodyMedium.copyWith(color: AppColors.darkText.withValues(alpha: 0.7))),
      overlayColor: WidgetStatePropertyAll(AppColors.primary.withValues(alpha: 0.12)),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.secondary,
      unselectedLabelColor: AppColors.darkText.withValues(alpha: 0.7),
      labelStyle: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700),
      unselectedLabelStyle: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600),
      indicatorColor: AppColors.secondary,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(AppColors.primary.withValues(alpha: 0.12)),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.darkText.withValues(alpha: 0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        splashFactory: InkRipple.splashFactory,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.secondary,
        textStyle: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.darkSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.darkText),
    ),
  );
}
