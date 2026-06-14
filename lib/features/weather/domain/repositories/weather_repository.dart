import '../../../cities/domain/entities/city.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
    String? name,
    String? country,
  });

  Future<Weather> getWeatherByCity(String cityName);

  Future<Weather> getCurrentLocationWeather();

  Future<List<City>> searchCities(String query);
}
