import 'package:go_router/go_router.dart';

import '../../features/cities/presentation/screens/cities_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/weather/presentation/screens/home_screen.dart';
import '../../features/weather/presentation/screens/precipitation_screen.dart';
import '../../features/weather/presentation/screens/weather_map_screen.dart';
import 'route_names.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.home,
    routes: [
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RouteNames.precipitation,
        builder: (context, state) => const PrecipitationScreen(),
      ),
      GoRoute(
        path: RouteNames.weatherMap,
        builder: (context, state) => const WeatherMapScreen(),
      ),
      GoRoute(
        path: RouteNames.cities,
        builder: (context, state) => const CitiesScreen(),
      ),
      GoRoute(
        path: RouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
