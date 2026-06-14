import 'package:equatable/equatable.dart';

class City extends Equatable {
  const City({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.adminArea,
  });

  final String name;
  final String country;
  final double latitude;
  final double longitude;
  final String? adminArea;

  String get displayName {
    if (adminArea == null || adminArea!.isEmpty) {
      return '$name, $country';
    }

    return '$name, $adminArea, $country';
  }

  @override
  List<Object?> get props => [name, country, latitude, longitude, adminArea];
}
