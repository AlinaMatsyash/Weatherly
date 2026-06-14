import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeatherByCoordinates {
  const GetWeatherByCoordinates(this.repository);

  final WeatherRepository repository;

  Future<Weather> call({
    required double latitude,
    required double longitude,
    String? name,
    String? country,
  }) {
    return repository.getWeatherByCoordinates(
      latitude: latitude,
      longitude: longitude,
      name: name,
      country: country,
    );
  }
}
