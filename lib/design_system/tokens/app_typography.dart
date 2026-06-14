import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/weatherly_colors.dart';

abstract final class AppTypography {
  static TextTheme textTheme(WeatherlyColors colors) {
    final base = GoogleFonts.interTextTheme();

    return base.copyWith(
      displayLarge: GoogleFonts.inter(
        color: colors.textPrimary,
        fontSize: 72,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        height: 0.95,
      ),
      headlineLarge: GoogleFonts.inter(
        color: colors.textPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      titleLarge: GoogleFonts.inter(
        color: colors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.inter(
        color: colors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      titleSmall: GoogleFonts.inter(
        color: colors.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      bodyLarge: GoogleFonts.inter(
        color: colors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      ),
      bodyMedium: GoogleFonts.inter(
        color: colors.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      ),
      bodySmall: GoogleFonts.inter(
        color: colors.textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      labelLarge: GoogleFonts.inter(
        color: colors.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      labelMedium: GoogleFonts.inter(
        color: colors.textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      ),
    );
  }
}
