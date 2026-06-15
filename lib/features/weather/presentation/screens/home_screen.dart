import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../design_system/theme/weatherly_colors.dart';
import '../../../../design_system/tokens/app_gradients.dart';
import '../../../../design_system/tokens/app_spacing.dart';
import '../../../../design_system/widgets/daily_forecast_tile.dart';
import '../../../../design_system/widgets/error_state.dart';
import '../../../../design_system/widgets/hourly_forecast_item.dart';
import '../../../../design_system/widgets/loading_state.dart';
import '../../../../design_system/widgets/precipitation_chart.dart';
import '../../../../design_system/widgets/rain_alert_card.dart';
import '../../../../design_system/widgets/weather_card.dart';
import '../../../../design_system/widgets/weather_metric_card.dart';
import '../../domain/entities/hourly_weather.dart';
import '../../domain/entities/weather.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    final bloc = context.read<WeatherBloc>();
    if (bloc.state.status == WeatherStatus.initial) {
      bloc.add(const WeatherStarted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: switch (state.status) {
              WeatherStatus.initial || WeatherStatus.loading => const Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: LoadingState(message: 'Loading San Francisco weather'),
              ),
              WeatherStatus.failure => ErrorState(
                title: 'Could not load weather',
                message: state.errorMessage ?? 'Please try again.',
                onRetry: () {
                  context.read<WeatherBloc>().add(
                    const WeatherRefreshRequested(),
                  );
                },
              ),
              WeatherStatus.success => _HomeContent(weather: state.weather!),
            },
          ),
        );
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.weatherlyColors;
    final hourly = weather.hourly.take(6).toList();
    final daily = weather.daily.take(7).toList();

    return RefreshIndicator(
      color: colors.primary,
      backgroundColor: colors.surface,
      onRefresh: () async {
        context.read<WeatherBloc>().add(const WeatherRefreshRequested());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HomeHeader(weather: weather, colors: colors),
            const SizedBox(height: AppSpacing.xl),
            _CurrentWeatherHero(weather: weather, colors: colors),
            const SizedBox(height: AppSpacing.md),
            RainAlertCard(
              title: _rainAlertTitle(weather),
              value: _rainAlertValue(weather),
              subtitle: _rainAlertSubtitle(weather),
              onTap: () => context.go(RouteNames.precipitation),
            ),
            const SizedBox(height: AppSpacing.md),
            WeatherCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: 'Hourly Forecast', action: 'See all'),
                  const SizedBox(height: AppSpacing.sm),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var index = 0; index < hourly.length; index++) ...[
                          HourlyForecastItem(
                            time: index == 0
                                ? 'Now'
                                : DateFormatter.hour(hourly[index].time),
                            temperature: _temperature(
                              hourly[index].temperature,
                            ),
                            precipitationProbability:
                                '${hourly[index].precipitationProbability}%',
                            icon: _iconFor(hourly[index].iconKey),
                          ),
                          if (index != hourly.length - 1)
                            const SizedBox(width: AppSpacing.xs),
                        ],
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
                  PrecipitationChart(
                    values: _precipitationValues(weather.hourly),
                    labels: _precipitationLabels(weather.hourly),
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
                  for (final item in daily)
                    DailyForecastTile(
                      day: DateFormatter.dayMonth(item.date),
                      minTemperature: _temperature(item.minTemperature),
                      maxTemperature: _temperature(item.maxTemperature),
                      precipitationProbability:
                          '${item.precipitationProbability}%',
                      icon: _iconFor(item.iconKey),
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
                  value: '${weather.current.humidity}%',
                  icon: PhosphorIcons.drop(PhosphorIconsStyle.duotone),
                  accentColor: colors.rain,
                ),
                WeatherMetricCard(
                  title: 'Wind',
                  value: '${weather.current.windSpeed.toStringAsFixed(1)} m/s',
                  subtitle: _windDirection(weather.current.windDirection),
                  icon: PhosphorIcons.wind(PhosphorIconsStyle.duotone),
                ),
                WeatherMetricCard(
                  title: 'UV Index',
                  value: weather.current.uvIndex.round().toString(),
                  subtitle: _uvLabel(weather.current.uvIndex),
                  icon: PhosphorIcons.sun(PhosphorIconsStyle.duotone),
                  accentColor: colors.warning,
                ),
                WeatherMetricCard(
                  title: 'Air Quality',
                  value: weather.airQuality?.aqi.toString() ?? '--',
                  subtitle: weather.airQuality?.label ?? 'Unavailable',
                  icon: PhosphorIcons.leaf(PhosphorIconsStyle.duotone),
                  accentColor: colors.success,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: Text(
                'Last updated ${DateFormatter.hour(weather.lastUpdated)}',
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.weather, required this.colors});

  final Weather weather;
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
              Text(weather.location.name, style: theme.textTheme.headlineLarge),
              Text(
                DateFormatter.dayMonth(weather.current.time),
                style: theme.textTheme.bodySmall,
              ),
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
  const _CurrentWeatherHero({required this.weather, required this.colors});

  final Weather weather;
  final WeatherlyColors colors;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final current = weather.current;
    final today = weather.daily.isEmpty ? null : weather.daily.first;

    return WeatherCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      gradient: AppGradients.night,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _temperature(current.temperature),
                  style: theme.textTheme.displayLarge,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(current.conditionLabel, style: theme.textTheme.bodyLarge),
                Text(
                  'Feels like ${_temperature(current.feelsLike)}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(_iconFor(current.iconKey), color: colors.warning, size: 88),
              const SizedBox(height: AppSpacing.md),
              Text(
                today == null
                    ? '-- / --'
                    : '${_temperature(today.maxTemperature)} / '
                          '${_temperature(today.minTemperature)}',
                style: theme.textTheme.bodyLarge,
              ),
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

String _temperature(double value) {
  return '${value.round()}°';
}

String _rainAlertTitle(Weather weather) {
  if (weather.precipitation.startsAt == null) {
    return 'No rain expected';
  }

  return 'Rain starting in';
}

String _rainAlertValue(Weather weather) {
  final message = weather.precipitation.startMessage;
  if (weather.precipitation.startsAt == null) {
    return 'Dry day';
  }

  return message.replaceFirst('Rain starting in ', '');
}

String _rainAlertSubtitle(Weather weather) {
  final amount = weather.precipitation.totalAmount;
  if (amount <= 0) {
    return 'Comfortable weather through the afternoon';
  }

  return 'Expected precipitation: ${amount.toStringAsFixed(1)} mm';
}

List<double> _precipitationValues(List<HourlyWeather> hourly) {
  final values = hourly
      .take(12)
      .map((item) => item.precipitationAmount)
      .toList();
  if (values.isEmpty) {
    return const [0];
  }

  return values;
}

List<String> _precipitationLabels(List<HourlyWeather> hourly) {
  final values = hourly.take(12).toList();
  if (values.isEmpty) {
    return const ['Now'];
  }

  return [
    for (var index = 0; index < values.length; index++)
      index == 0 || index == values.length ~/ 2 || index == values.length - 1
          ? DateFormatter.hour(values[index].time)
          : '',
  ];
}

String _uvLabel(double value) {
  if (value < 3) return 'Low';
  if (value < 6) return 'Moderate';
  if (value < 8) return 'High';
  if (value < 11) return 'Very High';
  return 'Extreme';
}

String _windDirection(int degrees) {
  final directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
  final index = ((degrees + 22.5) ~/ 45) % 8;

  return directions[index];
}

IconData _iconFor(String iconKey) {
  return switch (iconKey) {
    'sun' => PhosphorIcons.sun(PhosphorIconsStyle.duotone),
    'moon' => PhosphorIcons.moon(PhosphorIconsStyle.duotone),
    'cloud_sun' => PhosphorIcons.cloudSun(PhosphorIconsStyle.duotone),
    'cloud_moon' => PhosphorIcons.cloudMoon(PhosphorIconsStyle.duotone),
    'rain' => PhosphorIcons.cloudRain(PhosphorIconsStyle.duotone),
    'snow' => PhosphorIcons.cloudSnow(PhosphorIconsStyle.duotone),
    'storm' => PhosphorIcons.cloudLightning(PhosphorIconsStyle.duotone),
    'fog' => PhosphorIcons.cloudFog(PhosphorIconsStyle.duotone),
    _ => PhosphorIcons.cloud(PhosphorIconsStyle.duotone),
  };
}
