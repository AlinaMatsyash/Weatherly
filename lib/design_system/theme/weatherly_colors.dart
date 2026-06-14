import 'package:flutter/material.dart';

import '../tokens/app_colors.dart';

@immutable
class WeatherlyColors extends ThemeExtension<WeatherlyColors> {
  const WeatherlyColors({
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.border,
    required this.primary,
    required this.rain,
    required this.success,
    required this.warning,
    required this.error,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
  });

  factory WeatherlyColors.dark() {
    return const WeatherlyColors(
      background: AppColors.darkBackground,
      surface: AppColors.darkSurface,
      surfaceElevated: AppColors.darkSurfaceElevated,
      border: AppColors.darkBorder,
      primary: AppColors.primary,
      rain: AppColors.rain,
      success: AppColors.success,
      warning: AppColors.warning,
      error: AppColors.error,
      textPrimary: AppColors.darkTextPrimary,
      textSecondary: AppColors.darkTextSecondary,
      textTertiary: AppColors.darkTextTertiary,
    );
  }

  factory WeatherlyColors.light() {
    return const WeatherlyColors(
      background: AppColors.lightBackground,
      surface: AppColors.lightSurface,
      surfaceElevated: AppColors.lightSurfaceElevated,
      border: AppColors.lightBorder,
      primary: AppColors.lightPrimary,
      rain: AppColors.lightRain,
      success: AppColors.success,
      warning: AppColors.warning,
      error: AppColors.error,
      textPrimary: AppColors.lightTextPrimary,
      textSecondary: AppColors.lightTextSecondary,
      textTertiary: AppColors.lightTextTertiary,
    );
  }

  final Color background;
  final Color surface;
  final Color surfaceElevated;
  final Color border;
  final Color primary;
  final Color rain;
  final Color success;
  final Color warning;
  final Color error;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;

  @override
  WeatherlyColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceElevated,
    Color? border,
    Color? primary,
    Color? rain,
    Color? success,
    Color? warning,
    Color? error,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
  }) {
    return WeatherlyColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      border: border ?? this.border,
      primary: primary ?? this.primary,
      rain: rain ?? this.rain,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
    );
  }

  @override
  WeatherlyColors lerp(ThemeExtension<WeatherlyColors>? other, double t) {
    if (other is! WeatherlyColors) {
      return this;
    }

    return WeatherlyColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      border: Color.lerp(border, other.border, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      rain: Color.lerp(rain, other.rain, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
    );
  }
}

extension WeatherlyThemeColors on ThemeData {
  WeatherlyColors get weatherlyColors {
    return extension<WeatherlyColors>() ?? WeatherlyColors.dark();
  }
}
