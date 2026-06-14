import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../theme/weatherly_colors.dart';
import '../tokens/app_spacing.dart';
import 'weather_card.dart';

class RainAlertCard extends StatelessWidget {
  const RainAlertCard({
    required this.title,
    required this.value,
    required this.subtitle,
    this.onTap,
    super.key,
  });

  final String title;
  final String value;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.weatherlyColors;

    return WeatherCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.xxs),
                Text(value, style: theme.textTheme.titleLarge),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Icon(
            PhosphorIcons.cloudRain(PhosphorIconsStyle.duotone),
            color: colors.rain,
            size: 48,
          ),
          const SizedBox(width: AppSpacing.xs),
          Icon(
            PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
            color: colors.textSecondary,
            size: 18,
          ),
        ],
      ),
    );
  }
}
