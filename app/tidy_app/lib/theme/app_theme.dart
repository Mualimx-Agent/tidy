import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tidy Color Palette
/// Tiefes Salbei-Grün (Vertrauen, Natur) + Warm-Creme (Sauberkeit) + Akzent-Orange (Aktion)
class AppColors {
  // Primary: Tiefes Salbei-Grün
  static const Color primary = Color(0xFF5E7868);
  static const Color primaryLight = Color(0xFF7C9885);
  static const Color primaryDark = Color(0xFF3F5A4A);

  // Accent: Warm-Orange (für CTAs)
  static const Color accent = Color(0xFFD89570);
  static const Color accentLight = Color(0xFFE8B392);
  static const Color accentDark = Color(0xFFB57550);

  // Status-Farben
  static const Color success = Color(0xFF5E7868);
  static const Color warning = Color(0xFFD4A574);
  static const Color error = Color(0xFFB8747C);
  static const Color info = Color(0xFF6B8AA8);

  // Neutral
  static const Color background = Color(0xFFFAF8F4); // Warmes Creme
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0ECE3);
  static const Color onSurface = Color(0xFF2D2A26);
  static const Color onSurfaceVariant = Color(0xFF6B655C);

  // Dark Mode
  static const Color darkBackground = Color(0xFF1A1F1C);
  static const Color darkSurface = Color(0xFF252B27);
  static const Color darkSurfaceVariant = Color(0xFF2F3631);
  static const Color darkOnSurface = Color(0xFFE8E4DD);
  static const Color darkOnSurfaceVariant = Color(0xFFA8A29A);
}

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryLight,
        secondary: AppColors.accent,
        secondaryContainer: AppColors.accentLight,
        surface: AppColors.surface,
        surfaceContainerHighest: AppColors.surfaceVariant,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(
          fontSize: 48,
          fontWeight: FontWeight.w300,
          color: AppColors.onSurface,
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurface,
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: AppColors.onSurface,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.onSurfaceVariant,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryLight,
        primaryContainer: AppColors.primaryDark,
        secondary: AppColors.accentLight,
        secondaryContainer: AppColors.accentDark,
        surface: AppColors.darkSurface,
        surfaceContainerHighest: AppColors.darkSurfaceVariant,
        onSurface: AppColors.darkOnSurface,
        onSurfaceVariant: AppColors.darkOnSurfaceVariant,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkOnSurface,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
