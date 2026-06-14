import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../theme/weatherly_colors.dart';
import '../tokens/app_gradients.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';

class DailyForecastTile extends StatelessWidget {
  const DailyForecastTile({
    required this.day,
    required this.minTemperature,
    required this.maxTemperature,
    required this.precipitationProbability,
    this.icon,
    super.key,
  });

  final String day;
  final String minTemperature;
  final String maxTemperature;
  final String precipitationProbability;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.weatherlyColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              day,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Icon(
            icon ?? PhosphorIcons.cloudSun(PhosphorIconsStyle.duotone),
            color: colors.warning,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(minTemperature, style: theme.textTheme.bodyMedium),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            flex: 2,
            child: Container(
              height: 4,
              decoration: const BoxDecoration(
                gradient: AppGradients.sunny,
                borderRadius: AppRadius.smallBorder,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(maxTemperature, style: theme.textTheme.bodyMedium),
          const SizedBox(width: AppSpacing.sm),
          Text(
            precipitationProbability,
            style: theme.textTheme.labelMedium?.copyWith(color: colors.rain),
          ),
        ],
      ),
    );
  }
}
