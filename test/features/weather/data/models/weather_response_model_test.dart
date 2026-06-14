import 'package:flutter_test/flutter_test.dart';
import 'package:weatherly/features/cities/domain/entities/city.dart';
import 'package:weatherly/features/weather/data/models/air_quality_model.dart';
import 'package:weatherly/features/weather/data/models/weather_response_model.dart';

void main() {
  group('WeatherResponseModel', () {
    test('parses Open-Meteo response and maps it to domain entity', () {
      final model = WeatherResponseModel.fromJson(_weatherJson);
      final airQuality = AirQualityModel.fromJson(_airQualityJson).toEntity();
      final weather = model.toEntity(
        location: const City(
          name: 'Batumi',
          country: 'Georgia',
          latitude: 41.64,
          longitude: 41.64,
        ),
        airQuality: airQuality,
      );

      expect(weather.location.name, 'Batumi');
      expect(weather.current.temperature, 24);
      expect(weather.current.conditionLabel, 'Partly Cloudy');
      expect(weather.hourly, hasLength(4));
      expect(weather.daily, hasLength(2));
      expect(weather.airQuality?.aqi, 42);
      expect(weather.precipitation.totalAmount, 3.4);
      expect(weather.precipitation.intervals, isNotEmpty);
    });
  });
}

final _weatherJson = <String, dynamic>{
  'latitude': 41.64,
  'longitude': 41.64,
  'timezone': 'Asia/Tbilisi',
  'current': {
    'time': '2026-06-15T10:00',
    'temperature_2m': 24.0,
    'relative_humidity_2m': 62,
    'apparent_temperature': 22.0,
    'is_day': 1,
    'weather_code': 2,
    'wind_speed_10m': 3.6,
    'wind_direction_10m': 220,
    'uv_index': 5.0,
  },
  'hourly': {
    'time': [
      '2026-06-15T10:00',
      '2026-06-15T11:00',
      '2026-06-15T12:00',
      '2026-06-15T13:00',
    ],
    'temperature_2m': [24.0, 25.0, 26.0, 26.0],
    'apparent_temperature': [22.0, 23.0, 24.0, 24.0],
    'precipitation_probability': [30, 40, 40, 20],
    'precipitation': [0.0, 1.2, 2.2, 0.0],
    'weather_code': [2, 61, 63, 2],
    'wind_speed_10m': [3.6, 4.0, 4.2, 3.8],
    'uv_index': [4.0, 5.0, 5.0, 4.0],
  },
  'daily': {
    'time': ['2026-06-15', '2026-06-16'],
    'weather_code': [2, 61],
    'temperature_2m_max': [27.0, 26.0],
    'temperature_2m_min': [18.0, 17.0],
    'uv_index_max': [5.0, 4.0],
    'precipitation_sum': [3.4, 1.2],
    'precipitation_probability_max': [40, 20],
    'sunrise': ['2026-06-15T05:48', '2026-06-16T05:49'],
    'sunset': ['2026-06-15T20:31', '2026-06-16T20:31'],
  },
};

final _airQualityJson = <String, dynamic>{
  'hourly': {
    'us_aqi': [42],
    'pm2_5': [8.0],
    'pm10': [12.0],
    'ozone': [45.0],
    'nitrogen_dioxide': [14.0],
  },
};
