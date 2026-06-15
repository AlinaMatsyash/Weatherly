import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../design_system/theme/weatherly_dark_theme.dart';
import '../design_system/theme/weatherly_light_theme.dart';
import '../features/weather/presentation/bloc/weather_bloc.dart';
import 'di/service_locator.dart';
import 'router/app_router.dart';

class WeatherlyApp extends StatelessWidget {
  const WeatherlyApp({this.weatherBloc, super.key});

  final WeatherBloc? weatherBloc;

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp.router(
      title: 'Weatherly',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: WeatherlyLightTheme.theme,
      darkTheme: WeatherlyDarkTheme.theme,
      themeMode: ThemeMode.dark,
    );

    final bloc = weatherBloc;
    if (bloc != null) {
      return BlocProvider.value(value: bloc, child: app);
    }

    return BlocProvider(create: (_) => getIt<WeatherBloc>(), child: app);
  }
}
