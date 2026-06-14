import 'package:flutter/material.dart';

import '../design_system/theme/weatherly_dark_theme.dart';
import '../design_system/theme/weatherly_light_theme.dart';
import 'router/app_router.dart';

class WeatherlyApp extends StatelessWidget {
  const WeatherlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weatherly',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: WeatherlyLightTheme.theme,
      darkTheme: WeatherlyDarkTheme.theme,
      themeMode: ThemeMode.dark,
    );
  }
}
