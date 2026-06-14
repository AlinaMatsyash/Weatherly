import 'package:flutter_test/flutter_test.dart';
import 'package:weatherly/features/cities/domain/entities/city.dart';
import 'package:weatherly/features/weather/domain/entities/current_weather.dart';
import 'package:weatherly/features/weather/domain/entities/precipitation.dart';
import 'package:weatherly/features/weather/domain/entities/weather.dart';
import 'package:weatherly/features/weather/domain/repositories/weather_repository.dart';
import 'package:weatherly/features/weather/domain/usecases/get_weather_by_coordinates.dart';

void main() {
  test('delegates coordinate loading to repository', () async {
    final repository = _FakeWeatherRepository();
    final useCase = GetWeatherByCoordinates(repository);

    final weather = await useCase(
      latitude: 41.64,
      longitude: 41.64,
      name: 'Batumi',
      country: 'Georgia',
    );

    expect(weather.location.name, 'Batumi');
    expect(repository.lastLatitude, 41.64);
    expect(repository.lastLongitude, 41.64);
  });
}

class _FakeWeatherRepository implements WeatherRepository {
  double? lastLatitude;
  double? lastLongitude;

  @override
  Future<Weather> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
    String? name,
    String? country,
  }) async {
    lastLatitude = latitude;
    lastLongitude = longitude;

    return Weather(
      location: City(
        name: name ?? 'Selected Location',
        country: country ?? 'Unknown',
        latitude: latitude,
        longitude: longitude,
      ),
      latitude: latitude,
      longitude: longitude,
      timezone: 'Asia/Tbilisi',
      current: CurrentWeather(
        time: DateTime(2026, 6, 15, 10),
        temperature: 24,
        feelsLike: 22,
        conditionCode: 2,
        conditionLabel: 'Partly Cloudy',
        iconKey: 'cloud_sun',
        humidity: 62,
        windSpeed: 3.6,
        windDirection: 220,
        uvIndex: 5,
        isDay: true,
      ),
      hourly: const [],
      daily: const [],
      precipitation: const PrecipitationSummary(
        startMessage: 'No rain expected',
        totalAmount: 0,
        intervals: [],
        hourlyBars: [],
      ),
      lastUpdated: DateTime(2026, 6, 15, 10),
    );
  }

  @override
  Future<Weather> getCurrentLocationWeather() {
    throw UnimplementedError();
  }

  @override
  Future<Weather> getWeatherByCity(String cityName) {
    throw UnimplementedError();
  }

  @override
  Future<List<City>> searchCities(String query) {
    throw UnimplementedError();
  }
}
