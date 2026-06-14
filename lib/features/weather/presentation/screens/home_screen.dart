import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/theme/weatherly_colors.dart';
import '../../../../design_system/tokens/app_gradients.dart';
import '../../../../design_system/tokens/app_spacing.dart';
import '../../../../design_system/widgets/daily_forecast_tile.dart';
import '../../../../design_system/widgets/hourly_forecast_item.dart';
import '../../../../design_system/widgets/precipitation_chart.dart';
import '../../../../design_system/widgets/rain_alert_card.dart';
import '../../../../design_system/widgets/weather_card.dart';
import '../../../../design_system/widgets/weather_metric_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _chartValues = [
    0.2,
    0.4,
    0.8,
    1.4,
    2.8,
    3.8,
    2.4,
    3.1,
    2.7,
    1.8,
    1.1,
    0.4,
  ];

  static const _chartLabels = [
    '9:00',
    '',
    '',
    '',
    '',
    '',
    '15:00',
    '',
    '',
    '',
    '',
    '21:00',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.weatherlyColors;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HomeHeader(colors: colors),
              const SizedBox(height: AppSpacing.xl),
              _CurrentWeatherHero(colors: colors),
              const SizedBox(height: AppSpacing.md),
              RainAlertCard(
                title: 'Rain starting in',
                value: '40 min',
                subtitle: 'Take an umbrella with you',
                onTap: () => context.go(RouteNames.precipitation),
              ),
              const SizedBox(height: AppSpacing.md),
              WeatherCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionHeader(
                      title: 'Hourly Forecast',
                      action: 'See all',
                      onPressed: () {},
                    ),
                    const SizedBox(height: AppSpacing.sm),
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
                          SizedBox(width: AppSpacing.xs),
                          HourlyForecastItem(
                            time: '12:00',
                            temperature: '26°',
                            precipitationProbability: '20%',
                          ),
                          SizedBox(width: AppSpacing.xs),
                          HourlyForecastItem(
                            time: '13:00',
                            temperature: '26°',
                            precipitationProbability: '20%',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              WeatherCard(
                onTap: () => context.go(RouteNames.precipitation),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionHeader(
                      title: 'Precipitation',
                      action: 'See details',
                      onPressed: () => context.go(RouteNames.precipitation),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const PrecipitationChart(
                      values: _chartValues,
                      labels: _chartLabels,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              WeatherCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionHeader(title: '7-Day Forecast', action: 'See all'),
                    const SizedBox(height: AppSpacing.xs),
                    const DailyForecastTile(
                      day: 'Mon 21 May',
                      minTemperature: '18°',
                      maxTemperature: '27°',
                      precipitationProbability: '30%',
                    ),
                    const DailyForecastTile(
                      day: 'Tue 22 May',
                      minTemperature: '17°',
                      maxTemperature: '26°',
                      precipitationProbability: '20%',
                    ),
                    const DailyForecastTile(
                      day: 'Wed 23 May',
                      minTemperature: '16°',
                      maxTemperature: '24°',
                      precipitationProbability: '10%',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
                childAspectRatio: 1.55,
                children: [
                  WeatherMetricCard(
                    title: 'Humidity',
                    value: '62%',
                    icon: PhosphorIcons.drop(PhosphorIconsStyle.duotone),
                    accentColor: colors.rain,
                  ),
                  WeatherMetricCard(
                    title: 'Wind',
                    value: '3.6 m/s',
                    subtitle: 'SW',
                    icon: PhosphorIcons.wind(PhosphorIconsStyle.duotone),
                  ),
                  WeatherMetricCard(
                    title: 'UV Index',
                    value: '5',
                    subtitle: 'Moderate',
                    icon: PhosphorIcons.sun(PhosphorIconsStyle.duotone),
                    accentColor: colors.warning,
                  ),
                  WeatherMetricCard(
                    title: 'Air Quality',
                    value: '42',
                    subtitle: 'Good',
                    icon: PhosphorIcons.leaf(PhosphorIconsStyle.duotone),
                    accentColor: colors.success,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Center(
                child: Text(
                  'Last updated 5 min ago',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.colors});

  final WeatherlyColors colors;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        IconButton(
          tooltip: 'Settings',
          onPressed: () => context.go(RouteNames.settings),
          icon: Icon(PhosphorIcons.list(PhosphorIconsStyle.bold)),
        ),
        Expanded(
          child: Column(
            children: [
              Text('San Francisco', style: theme.textTheme.headlineLarge),
              Text('Today, 21 May', style: theme.textTheme.bodySmall),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Weather Map',
          onPressed: () => context.go(RouteNames.weatherMap),
          icon: Icon(
            PhosphorIcons.mapPin(PhosphorIconsStyle.bold),
            color: colors.primary,
          ),
        ),
        IconButton(
          tooltip: 'Cities',
          onPressed: () => context.go(RouteNames.cities),
          icon: Icon(PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.bold)),
        ),
      ],
    );
  }
}

class _CurrentWeatherHero extends StatelessWidget {
  const _CurrentWeatherHero({required this.colors});

  final WeatherlyColors colors;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WeatherCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      gradient: AppGradients.night,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('24°', style: theme.textTheme.displayLarge),
                const SizedBox(height: AppSpacing.xs),
                Text('Partly Cloudy', style: theme.textTheme.bodyLarge),
                Text('Feels like 22°', style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                PhosphorIcons.cloudSun(PhosphorIconsStyle.duotone),
                color: colors.warning,
                size: 88,
              ),
              const SizedBox(height: AppSpacing.md),
              Text('27° / 18°', style: theme.textTheme.bodyLarge),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.action, this.onPressed});

  final String title;
  final String? action;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).weatherlyColors;

    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleSmall),
        ),
        if (action != null)
          TextButton(
            onPressed: onPressed,
            child: Text(action!, style: TextStyle(color: colors.primary)),
          ),
      ],
    );
  }
}
