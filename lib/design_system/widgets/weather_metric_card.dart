import 'package:flutter/material.dart';

import '../theme/weatherly_colors.dart';
import '../tokens/app_spacing.dart';
import 'weather_card.dart';

class WeatherMetricCard extends StatelessWidget {
  const WeatherMetricCard({
    required this.title,
    required this.value,
    required this.icon,
    this.subtitle,
    this.accentColor,
    super.key,
  });

  final String title;
  final String value;
  final IconData icon;
  final String? subtitle;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.weatherlyColors;
    final color = accentColor ?? colors.primary;

    return WeatherCard(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: SizedBox(
        height: 72,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: theme.textTheme.titleMedium),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(color: color),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
