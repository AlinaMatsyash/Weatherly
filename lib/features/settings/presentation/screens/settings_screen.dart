import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/theme/weatherly_colors.dart';
import '../../../../design_system/tokens/app_spacing.dart';
import '../../../../design_system/widgets/weather_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => context.go(RouteNames.home),
          icon: Icon(PhosphorIcons.caretLeft(PhosphorIconsStyle.bold)),
        ),
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Appearance', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              const _SettingRow(
                icon: PhosphorIconsRegular.moon,
                title: 'Theme',
                value: 'Dark',
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Units', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              const _SettingRow(
                icon: PhosphorIconsRegular.thermometer,
                title: 'Temperature',
                value: 'Celsius',
              ),
              const SizedBox(height: AppSpacing.sm),
              const _SettingRow(
                icon: PhosphorIconsRegular.wind,
                title: 'Wind',
                value: 'm/s',
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Language', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              const _SettingRow(
                icon: PhosphorIconsRegular.translate,
                title: 'App Language',
                value: 'English',
              ),
              const SizedBox(height: AppSpacing.md),
              Text('About', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              const _SettingRow(
                icon: PhosphorIconsRegular.cloudSun,
                title: 'Weather Data',
                value: 'Open-Meteo',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.weatherlyColors;

    return WeatherCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Icon(icon, color: colors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(title, style: theme.textTheme.bodyMedium)),
          Text(value, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
