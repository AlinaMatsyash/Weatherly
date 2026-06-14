import '../../../../core/errors/failure.dart';
import '../../../../core/location/location_service.dart';
import '../../../cities/data/datasources/open_meteo_geocoding_remote_data_source.dart';
import '../../../cities/domain/entities/city.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/open_meteo_air_quality_remote_data_source.dart';
import '../datasources/open_meteo_weather_remote_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
    required this.airQualityRemoteDataSource,
    required this.geocodingRemoteDataSource,
    required this.locationService,
  });

  final OpenMeteoWeatherRemoteDataSource weatherRemoteDataSource;
  final OpenMeteoAirQualityRemoteDataSource airQualityRemoteDataSource;
  final OpenMeteoGeocodingRemoteDataSource geocodingRemoteDataSource;
  final LocationService locationService;

  @override
  Future<Weather> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
    String? name,
    String? country,
  }) async {
    final weather = await weatherRemoteDataSource.getForecast(
      latitude: latitude,
      longitude: longitude,
    );
    final airQuality = await airQualityRemoteDataSource.getAirQuality(
      latitude: latitude,
      longitude: longitude,
    );

    return weather.toEntity(
      location: City(
        name: name ?? _coordinateName(latitude, longitude),
        country: country ?? 'Selected Location',
        latitude: latitude,
        longitude: longitude,
      ),
      airQuality: airQuality.toEntity(),
    );
  }

  @override
  Future<Weather> getWeatherByCity(String cityName) async {
    final cities = await searchCities(cityName);
    if (cities.isEmpty) {
      throw WeatherException(ApiFailure('City "$cityName" was not found.'));
    }

    final city = cities.first;

    return getWeatherByCoordinates(
      latitude: city.latitude,
      longitude: city.longitude,
      name: city.name,
      country: city.country,
    );
  }

  @override
  Future<Weather> getCurrentLocationWeather() async {
    final coordinates = await locationService.getCurrentCoordinates();

    return getWeatherByCoordinates(
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
      name: 'Current Location',
      country: 'Nearby',
    );
  }

  @override
  Future<List<City>> searchCities(String query) async {
    final models = await geocodingRemoteDataSource.searchCities(query);

    return models.map((model) => model.toEntity()).toList();
  }

  String _coordinateName(double latitude, double longitude) {
    final lat = latitude.toStringAsFixed(2);
    final lon = longitude.toStringAsFixed(2);

    return '$lat, $lon';
  }
}
