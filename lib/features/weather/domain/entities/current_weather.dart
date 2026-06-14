import 'package:equatable/equatable.dart';

class CurrentWeather extends Equatable {
  const CurrentWeather({
    required this.time,
    required this.temperature,
    required this.feelsLike,
    required this.conditionCode,
    required this.conditionLabel,
    required this.iconKey,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.uvIndex,
    required this.isDay,
  });

  final DateTime time;
  final double temperature;
  final double feelsLike;
  final int conditionCode;
  final String conditionLabel;
  final String iconKey;
  final int humidity;
  final double windSpeed;
  final int windDirection;
  final double uvIndex;
  final bool isDay;

  @override
  List<Object?> get props => [
    time,
    temperature,
    feelsLike,
    conditionCode,
    conditionLabel,
    iconKey,
    humidity,
    windSpeed,
    windDirection,
    uvIndex,
    isDay,
  ];
}
