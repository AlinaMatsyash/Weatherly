import 'package:equatable/equatable.dart';

class HourlyWeather extends Equatable {
  const HourlyWeather({
    required this.time,
    required this.temperature,
    required this.feelsLike,
    required this.conditionCode,
    required this.conditionLabel,
    required this.iconKey,
    required this.precipitationProbability,
    required this.precipitationAmount,
    required this.windSpeed,
    required this.uvIndex,
  });

  final DateTime time;
  final double temperature;
  final double feelsLike;
  final int conditionCode;
  final String conditionLabel;
  final String iconKey;
  final int precipitationProbability;
  final double precipitationAmount;
  final double windSpeed;
  final double uvIndex;

  @override
  List<Object?> get props => [
    time,
    temperature,
    feelsLike,
    conditionCode,
    conditionLabel,
    iconKey,
    precipitationProbability,
    precipitationAmount,
    windSpeed,
    uvIndex,
  ];
}
