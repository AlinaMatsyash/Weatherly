import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/theme/weatherly_colors.dart';
import '../../../../design_system/tokens/app_radius.dart';
import '../../../../design_system/tokens/app_spacing.dart';
import '../../../../design_system/widgets/city_tile.dart';
import '../../../../design_system/widgets/weather_card.dart';

class CitiesScreen extends StatelessWidget {
  const CitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.weatherlyColors;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => context.go(RouteNames.home),
          icon: Icon(PhosphorIcons.caretLeft(PhosphorIconsStyle.bold)),
        ),
        title: const Text('Cities'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeatherCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    Icon(
                      PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.bold),
                      color: colors.textSecondary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Search city', style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Saved Cities', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              const CityTile(
                city: 'San Francisco',
                country: 'United States',
                temperature: '24°',
                selected: true,
              ),
              const SizedBox(height: AppSpacing.sm),
              const CityTile(
                city: 'New York',
                country: 'United States',
                temperature: '21°',
              ),
              const SizedBox(height: AppSpacing.sm),
              const CityTile(
                city: 'Batumi',
                country: 'Georgia',
                temperature: '24°',
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(PhosphorIcons.plus(PhosphorIconsStyle.bold)),
                  label: const Text('Add City'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.primary,
                    side: BorderSide(color: colors.border),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.mediumBorder,
                    ),
                    minimumSize: const Size.fromHeight(48),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
