import 'package:equatable/equatable.dart';

class DailyWeather extends Equatable {
  const DailyWeather({
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.conditionCode,
    required this.conditionLabel,
    required this.iconKey,
    required this.precipitationProbability,
    required this.precipitationSum,
    required this.uvIndex,
    required this.sunrise,
    required this.sunset,
  });

  final DateTime date;
  final double minTemperature;
  final double maxTemperature;
  final int conditionCode;
  final String conditionLabel;
  final String iconKey;
  final int precipitationProbability;
  final double precipitationSum;
  final double uvIndex;
  final DateTime sunrise;
  final DateTime sunset;

  @override
  List<Object?> get props => [
    date,
    minTemperature,
    maxTemperature,
    conditionCode,
    conditionLabel,
    iconKey,
    precipitationProbability,
    precipitationSum,
    uvIndex,
    sunrise,
    sunset,
  ];
}
