import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/weatherly_colors.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_shadows.dart';
import '../tokens/app_spacing.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.margin = EdgeInsets.zero,
    this.gradient,
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Gradient? gradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).weatherlyColors;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: AppRadius.largeBorder,
        boxShadow: AppShadows.soft,
      ),
      child: ClipRRect(
        borderRadius: AppRadius.largeBorder,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: AppRadius.largeBorder,
              child: Ink(
                padding: padding,
                decoration: BoxDecoration(
                  color: gradient == null
                      ? colors.surface.withValues(alpha: 0.82)
                      : null,
                  gradient: gradient,
                  borderRadius: AppRadius.largeBorder,
                  border: Border.all(color: colors.border),
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
