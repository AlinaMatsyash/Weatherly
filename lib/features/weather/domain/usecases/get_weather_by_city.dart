import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeatherByCity {
  const GetWeatherByCity(this.repository);

  final WeatherRepository repository;

  Future<Weather> call(String cityName) {
    return repository.getWeatherByCity(cityName);
  }
}
