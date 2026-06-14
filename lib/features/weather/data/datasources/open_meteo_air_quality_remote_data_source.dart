import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/dio_client.dart';
import '../models/air_quality_model.dart';

class OpenMeteoAirQualityRemoteDataSource {
  const OpenMeteoAirQualityRemoteDataSource(this.client);

  final DioClient client;

  Future<AirQualityModel> getAirQuality({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await client.dio.get<Map<String, dynamic>>(
        'https://air-quality-api.open-meteo.com/v1/air-quality',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'hourly': 'pm10,pm2_5,ozone,nitrogen_dioxide,us_aqi',
          'timezone': 'auto',
          'forecast_days': 1,
        },
      );

      return AirQualityModel.fromJson(response.data ?? {});
    } on DioException catch (error) {
      throw WeatherException(
        NetworkFailure(error.message ?? 'Air quality request failed.'),
      );
    } on Object catch (error) {
      throw WeatherException(ApiFailure('Air quality parsing failed: $error'));
    }
  }
}
