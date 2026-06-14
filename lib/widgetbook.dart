import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:widgetbook/widgetbook.dart';

import 'design_system/theme/weatherly_colors.dart';
import 'design_system/theme/weatherly_dark_theme.dart';
import 'design_system/theme/weatherly_light_theme.dart';
import 'design_system/tokens/app_gradients.dart';
import 'design_system/tokens/app_spacing.dart';
import 'design_system/widgets/city_tile.dart';
import 'design_system/widgets/daily_forecast_tile.dart';
import 'design_system/widgets/empty_state.dart';
import 'design_system/widgets/error_state.dart';
import 'design_system/widgets/hourly_forecast_item.dart';
import 'design_system/widgets/loading_state.dart';
import 'design_system/widgets/precipitation_chart.dart';
import 'design_system/widgets/rain_alert_card.dart';
import 'design_system/widgets/weather_card.dart';
import 'design_system/widgets/weather_metric_card.dart';

void main() {
  runApp(const WeatherlyWidgetbook());
}

class WeatherlyWidgetbook extends StatelessWidget {
  const WeatherlyWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      themeMode: ThemeMode.dark,
      lightTheme: WeatherlyLightTheme.theme,
      darkTheme: WeatherlyDarkTheme.theme,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Weatherly Dark',
              data: WeatherlyDarkTheme.theme,
            ),
            WidgetbookTheme(
              name: 'Weatherly Light',
              data: WeatherlyLightTheme.theme,
            ),
          ],
          initialTheme: WidgetbookTheme(
            name: 'Weatherly Dark',
            data: WeatherlyDarkTheme.theme,
          ),
        ),
        ViewportAddon(Viewports.all),
        AlignmentAddon(),
      ],
      directories: [
        WidgetbookCategory(
          name: 'Design System',
          isInitiallyExpanded: true,
          children: [
            WidgetbookComponent(
              name: 'WeatherCard',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (_) => const _PreviewPane(
                    child: WeatherCard(
                      child: Text('Premium glass weather card'),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Night Gradient',
                  builder: (_) => const _PreviewPane(
                    child: WeatherCard(
                      gradient: AppGradients.night,
                      child: _CurrentWeatherContent(),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'RainAlertCard',
              useCases: [
                WidgetbookUseCase(
                  name: 'Rain Starting',
                  builder: (_) => const _PreviewPane(
                    child: RainAlertCard(
                      title: 'Rain starting in',
                      value: '40 min',
                      subtitle: 'Take an umbrella with you',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'No Rain',
                  builder: (_) => const _PreviewPane(
                    child: RainAlertCard(
                      title: 'No rain expected',
                      value: 'Dry day',
                      subtitle: 'Comfortable weather through the afternoon',
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'WeatherMetricCard',
              useCases: [
                WidgetbookUseCase(
                  name: 'Metrics Grid',
                  builder: (_) => _PreviewPane(
                    child: Builder(
                      builder: (context) {
                        final colors = Theme.of(context).weatherlyColors;

                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: AppSpacing.sm,
                          mainAxisSpacing: AppSpacing.sm,
                          childAspectRatio: 1.55,
                          children: [
                            WeatherMetricCard(
                              title: 'Humidity',
                              value: '62%',
                              icon: PhosphorIcons.drop(
                                PhosphorIconsStyle.duotone,
                              ),
                              accentColor: colors.rain,
                            ),
                            WeatherMetricCard(
                              title: 'Wind',
                              value: '3.6 m/s',
                              subtitle: 'SW',
                              icon: PhosphorIcons.wind(
                                PhosphorIconsStyle.duotone,
                              ),
                            ),
                            WeatherMetricCard(
                              title: 'UV Index',
                              value: '5',
                              subtitle: 'Moderate',
                              icon: PhosphorIcons.sun(
                                PhosphorIconsStyle.duotone,
                              ),
                              accentColor: colors.warning,
                            ),
                            WeatherMetricCard(
                              title: 'Air Quality',
                              value: '42',
                              subtitle: 'Good',
                              icon: PhosphorIcons.leaf(
                                PhosphorIconsStyle.duotone,
                              ),
                              accentColor: colors.success,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HourlyForecastItem',
              useCases: [
                WidgetbookUseCase(
                  name: 'Timeline',
                  builder: (_) => const _PreviewPane(
                    child: SingleChildScrollView(
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'DailyForecastTile',
              useCases: [
                WidgetbookUseCase(
                  name: 'Week Rows',
                  builder: (_) => const _PreviewPane(
                    child: WeatherCard(
                      child: Column(
                        children: [
                          DailyForecastTile(
                            day: 'Mon 21 May',
                            minTemperature: '18°',
                            maxTemperature: '27°',
                            precipitationProbability: '30%',
                          ),
                          DailyForecastTile(
                            day: 'Tue 22 May',
                            minTemperature: '17°',
                            maxTemperature: '26°',
                            precipitationProbability: '20%',
                          ),
                          DailyForecastTile(
                            day: 'Wed 23 May',
                            minTemperature: '16°',
                            maxTemperature: '24°',
                            precipitationProbability: '10%',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'PrecipitationChart',
              useCases: [
                WidgetbookUseCase(
                  name: 'Rain Bars',
                  builder: (_) => const _PreviewPane(
                    child: WeatherCard(
                      child: PrecipitationChart(
                        values: [
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
                        ],
                        labels: [
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'CityTile',
              useCases: [
                WidgetbookUseCase(
                  name: 'Saved Cities',
                  builder: (_) => const _PreviewPane(
                    child: Column(
                      children: [
                        CityTile(
                          city: 'San Francisco',
                          country: 'United States',
                          temperature: '24°',
                          selected: true,
                        ),
                        SizedBox(height: AppSpacing.sm),
                        CityTile(
                          city: 'Batumi',
                          country: 'Georgia',
                          temperature: '24°',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'States',
              useCases: [
                WidgetbookUseCase(
                  name: 'Loading',
                  builder: (_) => const _PreviewPane(
                    child: SizedBox(height: 260, child: LoadingState()),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Error',
                  builder: (_) => const _PreviewPane(
                    child: SizedBox(
                      height: 260,
                      child: ErrorState(
                        title: 'Could not load weather',
                        message: 'Check your connection and try again.',
                      ),
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Empty',
                  builder: (_) => const _PreviewPane(
                    child: SizedBox(
                      height: 260,
                      child: EmptyState(
                        title: 'No cities yet',
                        message: 'Search and save your first city.',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'Screen Drafts',
          children: [
            WidgetbookComponent(
              name: 'Home Composition',
              useCases: [
                WidgetbookUseCase(
                  name: 'Sprint 1 Preview',
                  builder: (_) => const _PreviewPane(
                    maxWidth: 430,
                    child: _HomeCompositionPreview(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _PreviewPane extends StatelessWidget {
  const _PreviewPane({required this.child, this.maxWidth = 420});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).weatherlyColors;

    return ColoredBox(
      color: colors.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _CurrentWeatherContent extends StatelessWidget {
  const _CurrentWeatherContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.weatherlyColors;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('24°', style: theme.textTheme.displayLarge),
              Text('Partly Cloudy', style: theme.textTheme.bodyLarge),
              Text('Feels like 22°', style: theme.textTheme.bodySmall),
            ],
          ),
        ),
        Icon(
          PhosphorIcons.cloudSun(PhosphorIconsStyle.duotone),
          color: colors.warning,
          size: 88,
        ),
      ],
    );
  }
}

class _HomeCompositionPreview extends StatelessWidget {
  const _HomeCompositionPreview();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.weatherlyColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Text('San Francisco', style: theme.textTheme.headlineLarge),
              Text('Today, 21 May', style: theme.textTheme.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        const WeatherCard(
          gradient: AppGradients.night,
          child: _CurrentWeatherContent(),
        ),
        const SizedBox(height: AppSpacing.md),
        const RainAlertCard(
          title: 'Rain starting in',
          value: '40 min',
          subtitle: 'Take an umbrella with you',
        ),
        const SizedBox(height: AppSpacing.md),
        const WeatherCard(
          child: SingleChildScrollView(
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
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const WeatherCard(
          child: PrecipitationChart(
            values: [0.2, 0.4, 0.8, 1.4, 2.8, 3.8, 2.4, 3.1, 2.7, 1.8],
            labels: ['9:00', '', '', '', '', '12:00', '', '', '', '21:00'],
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
          ],
        ),
      ],
    );
  }
}
