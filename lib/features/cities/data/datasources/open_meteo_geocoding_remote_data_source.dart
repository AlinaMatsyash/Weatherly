import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/dio_client.dart';
import '../models/city_model.dart';

class OpenMeteoGeocodingRemoteDataSource {
  const OpenMeteoGeocodingRemoteDataSource(this.client);

  final DioClient client;

  Future<List<CityModel>> searchCities(String query) async {
    if (query.trim().isEmpty) {
      return const [];
    }

    try {
      final response = await client.dio.get<Map<String, dynamic>>(
        'https://geocoding-api.open-meteo.com/v1/search',
        queryParameters: {
          'name': query,
          'count': 10,
          'language': 'en',
          'format': 'json',
        },
      );

      final results = response.data?['results'] as List<dynamic>? ?? [];

      return results
          .whereType<Map<String, dynamic>>()
          .map(CityModel.fromJson)
          .toList();
    } on DioException catch (error) {
      throw WeatherException(
        NetworkFailure(error.message ?? 'City search failed.'),
      );
    } on Object catch (error) {
      throw WeatherException(ApiFailure('City search failed: $error'));
    }
  }
}
