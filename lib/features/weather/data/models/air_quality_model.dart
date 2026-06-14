import '../../domain/entities/air_quality.dart';

class AirQualityModel {
  const AirQualityModel({
    required this.aqi,
    required this.pm25,
    required this.pm10,
    required this.ozone,
    required this.nitrogenDioxide,
  });

  factory AirQualityModel.empty() {
    return const AirQualityModel(
      aqi: 0,
      pm25: 0,
      pm10: 0,
      ozone: 0,
      nitrogenDioxide: 0,
    );
  }

  factory AirQualityModel.fromJson(Map<String, dynamic> json) {
    final hourly = json['hourly'] as Map<String, dynamic>? ?? {};

    return AirQualityModel(
      aqi: _firstInt(hourly['us_aqi']),
      pm25: _firstDouble(hourly['pm2_5']),
      pm10: _firstDouble(hourly['pm10']),
      ozone: _firstDouble(hourly['ozone']),
      nitrogenDioxide: _firstDouble(hourly['nitrogen_dioxide']),
    );
  }

  final int aqi;
  final double pm25;
  final double pm10;
  final double ozone;
  final double nitrogenDioxide;

  AirQuality toEntity() {
    return AirQuality(
      aqi: aqi,
      label: _label(aqi),
      pm25: pm25,
      pm10: pm10,
      ozone: ozone,
      nitrogenDioxide: nitrogenDioxide,
      recommendation: _recommendation(aqi),
    );
  }

  static int _firstInt(Object? value) {
    if (value is List && value.isNotEmpty) {
      return (value.first as num?)?.round() ?? 0;
    }

    return 0;
  }

  static double _firstDouble(Object? value) {
    if (value is List && value.isNotEmpty) {
      return (value.first as num?)?.toDouble() ?? 0;
    }

    return 0;
  }

  static String _label(int aqi) {
    if (aqi <= 50) return 'Good';
    if (aqi <= 100) return 'Moderate';
    if (aqi <= 150) return 'Unhealthy for Sensitive Groups';
    if (aqi <= 200) return 'Unhealthy';
    if (aqi <= 300) return 'Very Unhealthy';
    return 'Hazardous';
  }

  static String _recommendation(int aqi) {
    if (aqi <= 50) {
      return 'Outdoor activity is comfortable for most people.';
    }

    if (aqi <= 100) {
      return 'Sensitive users should monitor symptoms outdoors.';
    }

    return 'Reduce prolonged outdoor activity.';
  }
}
