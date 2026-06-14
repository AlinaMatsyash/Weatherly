import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../theme/weatherly_colors.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';

class HourlyForecastItem extends StatelessWidget {
  const HourlyForecastItem({
    required this.time,
    required this.temperature,
    required this.precipitationProbability,
    this.icon,
    super.key,
  });

  final String time;
  final String temperature;
  final String precipitationProbability;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.weatherlyColors;

    return Container(
      width: 58,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceElevated.withValues(alpha: 0.58),
        borderRadius: AppRadius.mediumBorder,
        border: Border.all(color: colors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Icon(
            icon ?? PhosphorIcons.cloudSun(PhosphorIconsStyle.duotone),
            color: colors.warning,
            size: 24,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(temperature, style: theme.textTheme.titleSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            precipitationProbability,
            style: theme.textTheme.labelMedium?.copyWith(color: colors.rain),
          ),
        ],
      ),
    );
  }
}
