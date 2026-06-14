import 'package:flutter/material.dart';

import '../tokens/app_radius.dart';
import '../tokens/app_typography.dart';
import 'weatherly_colors.dart';

abstract final class WeatherlyDarkTheme {
  static ThemeData get theme {
    final colors = WeatherlyColors.dark();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        secondary: colors.rain,
        surface: colors.surface,
        error: colors.error,
      ),
      extensions: [colors],
      textTheme: AppTypography.textTheme(colors),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: colors.textPrimary,
          minimumSize: const Size(44, 44),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.mediumBorder,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.textPrimary,
          minimumSize: const Size(44, 44),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.mediumBorder,
          ),
        ),
      ),
    );
  }
}
