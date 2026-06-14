import 'package:geolocator/geolocator.dart';

import '../errors/failure.dart';

class LocationCoordinates {
  const LocationCoordinates({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;
}

class LocationService {
  Future<LocationCoordinates> getCurrentCoordinates() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      throw const WeatherException(
        LocationFailure('Location services are disabled.'),
      );
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw const WeatherException(
        LocationFailure('Location permission was denied.'),
      );
    }

    if (permission == LocationPermission.deniedForever) {
      throw const WeatherException(
        LocationFailure('Location permission is permanently denied.'),
      );
    }

    final position = await Geolocator.getCurrentPosition();

    return LocationCoordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
