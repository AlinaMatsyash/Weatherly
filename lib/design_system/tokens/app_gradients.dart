import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppGradients {
  static const sunny = LinearGradient(
    colors: [AppColors.primary, Color(0xFF7CC6FF)],
  );

  static const rainy = LinearGradient(
    colors: [Color(0xFF1E3A5F), Color(0xFF3B82F6)],
  );

  static const night = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.darkBackground, AppColors.darkSurfaceElevated],
  );

  static const storm = LinearGradient(
    colors: [Color(0xFF111827), Color(0xFF334155)],
  );
}
