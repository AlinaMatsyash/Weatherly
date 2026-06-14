import 'package:equatable/equatable.dart';

class AirQuality extends Equatable {
  const AirQuality({
    required this.aqi,
    required this.label,
    required this.pm25,
    required this.pm10,
    required this.ozone,
    required this.nitrogenDioxide,
    required this.recommendation,
  });

  final int aqi;
  final String label;
  final double pm25;
  final double pm10;
  final double ozone;
  final double nitrogenDioxide;
  final String recommendation;

  @override
  List<Object?> get props => [
    aqi,
    label,
    pm25,
    pm10,
    ozone,
    nitrogenDioxide,
    recommendation,
  ];
}
