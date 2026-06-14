import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/theme/weatherly_colors.dart';
import '../../../../design_system/tokens/app_spacing.dart';
import '../../../../design_system/widgets/precipitation_chart.dart';
import '../../../../design_system/widgets/weather_card.dart';

class PrecipitationScreen extends StatelessWidget {
  const PrecipitationScreen({super.key});

  static const _values = [
    0.5,
    1.4,
    2.1,
    4.2,
    6.1,
    5.0,
    3.2,
    3.8,
    4.4,
    4.4,
    2.6,
    1.2,
  ];

  static const _labels = [
    '9:00',
    '',
    '',
    '',
    '12:00',
    '',
    '',
    '',
    '15:00',
    '',
    '',
    '21:00',
  ];

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
        title: const Text('Precipitation'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeatherCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rain starting in',
                                style: theme.textTheme.bodyMedium,
                              ),
                              Text('40 min', style: theme.textTheme.titleLarge),
                              Text(
                                'Intensity',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Icon(
                              PhosphorIcons.cloudRain(
                                PhosphorIconsStyle.duotone,
                              ),
                              color: colors.rain,
                              size: 56,
                            ),
                            Text('Heavy', style: theme.textTheme.titleSmall),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const PrecipitationChart(values: _values, labels: _labels),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              WeatherCard(
                child: Column(
                  children: const [
                    _RainInterval(
                      time: '10:20 - 11:30',
                      title: 'Heavy Rain',
                      amount: '10.2 mm',
                    ),
                    _RainInterval(
                      time: '11:30 - 14:00',
                      title: 'Moderate Rain',
                      amount: '4.5 mm',
                    ),
                    _RainInterval(
                      time: '14:00 - 17:20',
                      title: 'Light Rain',
                      amount: '1.1 mm',
                    ),
                    _RainInterval(
                      time: '17:20 - 21:00',
                      title: 'No Rain',
                      amount: '0 mm',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              WeatherCard(
                child: Row(
                  children: [
                    Icon(
                      PhosphorIcons.cloudRain(PhosphorIconsStyle.duotone),
                      color: colors.rain,
                      size: 44,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        'Rain from 10:20 to 17:20. Heavy rain in the morning. '
                        'Light rain in the afternoon.',
                        style: theme.textTheme.bodyMedium,
                      ),
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

class _RainInterval extends StatelessWidget {
  const _RainInterval({
    required this.time,
    required this.title,
    required this.amount,
  });

  final String time;
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.weatherlyColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(
            PhosphorIcons.cloudRain(PhosphorIconsStyle.duotone),
            color: colors.rain,
            size: 28,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time, style: theme.textTheme.bodyMedium),
                Text(title, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          Text(
            amount,
            style: theme.textTheme.bodyMedium?.copyWith(color: colors.rain),
          ),
        ],
      ),
    );
  }
}
