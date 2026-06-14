import '../../domain/entities/city.dart';

class CityModel {
  const CityModel({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.adminArea,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'] as String? ?? 'Unknown',
      country: json['country'] as String? ?? 'Unknown',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      adminArea: json['admin1'] as String?,
    );
  }

  final String name;
  final String country;
  final double latitude;
  final double longitude;
  final String? adminArea;

  City toEntity() {
    return City(
      name: name,
      country: country,
      latitude: latitude,
      longitude: longitude,
      adminArea: adminArea,
    );
  }
}
