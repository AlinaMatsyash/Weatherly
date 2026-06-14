import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentLocationWeather {
  const GetCurrentLocationWeather(this.repository);

  final WeatherRepository repository;

  Future<Weather> call() {
    return repository.getCurrentLocationWeather();
  }
}
