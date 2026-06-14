import 'package:equatable/equatable.dart';

import '../../../cities/domain/entities/city.dart';
import 'air_quality.dart';
import 'current_weather.dart';
import 'daily_weather.dart';
import 'hourly_weather.dart';
import 'precipitation.dart';

class Weather extends Equatable {
  const Weather({
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.current,
    required this.hourly,
    required this.daily,
    required this.precipitation,
    required this.lastUpdated,
    this.airQuality,
  });

  final City location;
  final double latitude;
  final double longitude;
  final String timezone;
  final CurrentWeather current;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;
  final PrecipitationSummary precipitation;
  final AirQuality? airQuality;
  final DateTime lastUpdated;

  @override
  List<Object?> get props => [
    location,
    latitude,
    longitude,
    timezone,
    current,
    hourly,
    daily,
    precipitation,
    airQuality,
    lastUpdated,
  ];
}
