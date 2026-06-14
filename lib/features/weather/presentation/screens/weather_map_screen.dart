import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/theme/weatherly_colors.dart';
import '../../../../design_system/tokens/app_gradients.dart';
import '../../../../design_system/tokens/app_radius.dart';
import '../../../../design_system/tokens/app_spacing.dart';
import '../../../../design_system/widgets/hourly_forecast_item.dart';
import '../../../../design_system/widgets/weather_card.dart';

class WeatherMapScreen extends StatelessWidget {
  const WeatherMapScreen({super.key});

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
        title: const Text('Weather Map'),
        actions: [
          IconButton(
            tooltip: 'Current location',
            onPressed: () {},
            icon: Icon(PhosphorIcons.crosshair(PhosphorIconsStyle.bold)),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppGradients.rainy,
                    borderRadius: AppRadius.largeBorder,
                    border: Border.all(color: colors.border),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          PhosphorIcons.mapPin(PhosphorIconsStyle.fill),
                          color: colors.textPrimary,
                          size: 64,
                        ),
                      ),
                      Positioned(
                        left: AppSpacing.md,
                        top: AppSpacing.md,
                        child: Text(
                          'OpenStreetMap preview',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              WeatherCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          PhosphorIcons.cloudSun(PhosphorIconsStyle.duotone),
                          color: colors.warning,
                          size: 48,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'San Francisco',
                                style: theme.textTheme.titleLarge,
                              ),
                              Text(
                                'Partly Cloudy',
                                style: theme.textTheme.bodySmall,
                              ),
                              Text(
                                'Feels like 22°',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Text('24°', style: theme.textTheme.titleLarge),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Rain starting in 40 min · Precipitation: 1.8 mm',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.rain,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          HourlyForecastItem(
                            time: 'Now',
                            temperature: '24°',
                            precipitationProbability: '30%',
                          ),
                          SizedBox(width: AppSpacing.xs),
                          HourlyForecastItem(
                            time: '10:00',
                            temperature: '24°',
                            precipitationProbability: '40%',
                          ),
                          SizedBox(width: AppSpacing.xs),
                          HourlyForecastItem(
                            time: '11:00',
                            temperature: '25°',
                            precipitationProbability: '40%',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Save City'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => context.go(RouteNames.home),
                            child: const Text('View Details'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
