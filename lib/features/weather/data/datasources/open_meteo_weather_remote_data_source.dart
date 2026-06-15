import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/dio_client.dart';
import '../models/weather_response_model.dart';

class OpenMeteoWeatherRemoteDataSource {
  const OpenMeteoWeatherRemoteDataSource(this.client);

  final DioClient client;

  Future<WeatherResponseModel> getForecast({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await client.dio.get<Map<String, dynamic>>(
        'https://api.open-meteo.com/v1/forecast',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'current': [
            'temperature_2m',
            'relative_humidity_2m',
            'apparent_temperature',
            'is_day',
            'weather_code',
            'wind_speed_10m',
            'wind_direction_10m',
            'uv_index',
          ].join(','),
          'hourly': [
            'temperature_2m',
            'apparent_temperature',
            'precipitation_probability',
            'precipitation',
            'weather_code',
            'wind_speed_10m',
            'uv_index',
          ].join(','),
          'daily': [
            'weather_code',
            'temperature_2m_max',
            'temperature_2m_min',
            'uv_index_max',
            'precipitation_sum',
            'precipitation_probability_max',
            'sunrise',
            'sunset',
          ].join(','),
          'timezone': 'auto',
          'wind_speed_unit': 'ms',
          'forecast_days': 7,
        },
      );

      return WeatherResponseModel.fromJson(response.data ?? {});
    } on DioException catch (error) {
      throw WeatherException(
        NetworkFailure(error.message ?? 'Weather request failed.'),
      );
    } on Object catch (error) {
      throw WeatherException(ApiFailure('Weather parsing failed: $error'));
    }
  }
}
