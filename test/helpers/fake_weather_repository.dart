import 'package:weatherly/core/errors/failure.dart';
import 'package:weatherly/features/cities/domain/entities/city.dart';
import 'package:weatherly/features/weather/domain/entities/air_quality.dart';
import 'package:weatherly/features/weather/domain/entities/current_weather.dart';
import 'package:weatherly/features/weather/domain/entities/daily_weather.dart';
import 'package:weatherly/features/weather/domain/entities/hourly_weather.dart';
import 'package:weatherly/features/weather/domain/entities/precipitation.dart';
import 'package:weatherly/features/weather/domain/entities/weather.dart';
import 'package:weatherly/features/weather/domain/repositories/weather_repository.dart';

class FakeWeatherRepository implements WeatherRepository {
  FakeWeatherRepository({this.shouldFail = false});

  final bool shouldFail;
  String? lastCityName;

  @override
  Future<Weather> getWeatherByCity(String cityName) async {
    lastCityName = cityName;

    if (shouldFail) {
      throw const WeatherException(NetworkFailure('Network unavailable.'));
    }

    return buildTestWeather(cityName: cityName);
  }

  @override
  Future<Weather> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
    String? name,
    String? country,
  }) async {
    return buildTestWeather(cityName: name ?? 'Selected Location');
  }

  @override
  Future<Weather> getCurrentLocationWeather() async {
    return buildTestWeather(cityName: 'Current Location');
  }

  @override
  Future<List<City>> searchCities(String query) async {
    return [
      City(
        name: query,
        country: 'United States',
        latitude: 37.77,
        longitude: -122.42,
      ),
    ];
  }
}

Weather buildTestWeather({String cityName = 'San Francisco'}) {
  final now = DateTime(2026, 6, 15, 10);

  return Weather(
    location: City(
      name: cityName,
      country: 'United States',
      latitude: 37.77,
      longitude: -122.42,
    ),
    latitude: 37.77,
    longitude: -122.42,
    timezone: 'America/Los_Angeles',
    current: CurrentWeather(
      time: now,
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
    hourly: [
      for (var index = 0; index < 12; index++)
        HourlyWeather(
          time: now.add(Duration(hours: index)),
          temperature: 24 + (index % 3),
          feelsLike: 22 + (index % 3),
          conditionCode: index == 2 ? 61 : 2,
          conditionLabel: index == 2 ? 'Rain' : 'Partly Cloudy',
          iconKey: index == 2 ? 'rain' : 'cloud_sun',
          precipitationProbability: index < 3 ? 40 : 20,
          precipitationAmount: index == 2 || index == 3 ? 1.2 : 0,
          windSpeed: 3.6,
          uvIndex: 5,
        ),
    ],
    daily: [
      for (var index = 0; index < 7; index++)
        DailyWeather(
          date: DateTime(2026, 6, 15 + index),
          minTemperature: 18 - (index % 2),
          maxTemperature: 27 - (index % 3),
          conditionCode: index == 1 ? 61 : 2,
          conditionLabel: index == 1 ? 'Rain' : 'Partly Cloudy',
          iconKey: index == 1 ? 'rain' : 'cloud_sun',
          precipitationProbability: index == 1 ? 40 : 20,
          precipitationSum: index == 1 ? 2.4 : 0,
          uvIndex: 5,
          sunrise: DateTime(2026, 6, 15 + index, 5, 48),
          sunset: DateTime(2026, 6, 15 + index, 20, 31),
        ),
    ],
    precipitation: PrecipitationSummary(
      startsAt: now.add(const Duration(hours: 2)),
      startMessage: 'Rain starting in 2 h',
      totalAmount: 2.4,
      intervals: [
        PrecipitationInterval(
          start: now.add(const Duration(hours: 2)),
          end: now.add(const Duration(hours: 4)),
          intensityLabel: 'Moderate Rain',
          amount: 2.4,
        ),
      ],
      hourlyBars: [
        for (var index = 0; index < 12; index++)
          PrecipitationBar(
            time: now.add(Duration(hours: index)),
            amount: index == 2 || index == 3 ? 1.2 : 0,
            probability: index < 3 ? 40 : 20,
          ),
      ],
    ),
    airQuality: const AirQuality(
      aqi: 42,
      label: 'Good',
      pm25: 8,
      pm10: 12,
      ozone: 45,
      nitrogenDioxide: 14,
      recommendation: 'Outdoor activity is comfortable for most people.',
    ),
    lastUpdated: now,
  );
}
