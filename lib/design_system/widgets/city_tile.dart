import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../theme/weatherly_colors.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';

class CityTile extends StatelessWidget {
  const CityTile({
    required this.city,
    required this.country,
    required this.temperature,
    this.selected = false,
    this.onTap,
    super.key,
  });

  final String city;
  final String country;
  final String temperature;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.weatherlyColors;

    return Material(
      color: selected
          ? colors.primary.withValues(alpha: 0.16)
          : colors.surface.withValues(alpha: 0.72),
      borderRadius: AppRadius.largeBorder,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.largeBorder,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: AppRadius.largeBorder,
            border: Border.all(
              color: selected ? colors.primary : colors.border,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: colors.primary.withValues(alpha: 0.18),
                foregroundColor: colors.primary,
                child: Icon(PhosphorIcons.city(PhosphorIconsStyle.duotone)),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(city, style: theme.textTheme.titleSmall),
                    Text(country, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Text(temperature, style: theme.textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
