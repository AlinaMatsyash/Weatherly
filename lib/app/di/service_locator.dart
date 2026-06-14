import 'package:get_it/get_it.dart';

import '../../core/location/location_service.dart';
import '../../core/network/dio_client.dart';
import '../../features/cities/data/datasources/open_meteo_geocoding_remote_data_source.dart';
import '../../features/weather/data/datasources/open_meteo_air_quality_remote_data_source.dart';
import '../../features/weather/data/datasources/open_meteo_weather_remote_data_source.dart';
import '../../features/weather/data/repositories/weather_repository_impl.dart';
import '../../features/weather/domain/repositories/weather_repository.dart';
import '../../features/weather/domain/usecases/get_current_location_weather.dart';
import '../../features/weather/domain/usecases/get_weather_by_city.dart';
import '../../features/weather/domain/usecases/get_weather_by_coordinates.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  if (getIt.isRegistered<AppBootstrapMarker>()) {
    return;
  }

  getIt
    ..registerLazySingleton(DioClient.new)
    ..registerLazySingleton(LocationService.new)
    ..registerLazySingleton(
      () => OpenMeteoWeatherRemoteDataSource(getIt<DioClient>()),
    )
    ..registerLazySingleton(
      () => OpenMeteoAirQualityRemoteDataSource(getIt<DioClient>()),
    )
    ..registerLazySingleton(
      () => OpenMeteoGeocodingRemoteDataSource(getIt<DioClient>()),
    )
    ..registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(
        weatherRemoteDataSource: getIt<OpenMeteoWeatherRemoteDataSource>(),
        airQualityRemoteDataSource:
            getIt<OpenMeteoAirQualityRemoteDataSource>(),
        geocodingRemoteDataSource: getIt<OpenMeteoGeocodingRemoteDataSource>(),
        locationService: getIt<LocationService>(),
      ),
    )
    ..registerLazySingleton(
      () => GetWeatherByCoordinates(getIt<WeatherRepository>()),
    )
    ..registerLazySingleton(() => GetWeatherByCity(getIt<WeatherRepository>()))
    ..registerLazySingleton(
      () => GetCurrentLocationWeather(getIt<WeatherRepository>()),
    );

  getIt.registerSingleton(const AppBootstrapMarker());
}

class AppBootstrapMarker {
  const AppBootstrapMarker();
}
