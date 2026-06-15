import 'package:equatable/equatable.dart';

import '../../domain/entities/weather.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherState extends Equatable {
  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weather,
    this.selectedCityName = 'San Francisco',
    this.errorMessage,
  });

  final WeatherStatus status;
  final Weather? weather;
  final String selectedCityName;
  final String? errorMessage;

  bool get hasWeather => weather != null;

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    String? selectedCityName,
    String? errorMessage,
    bool clearError = false,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      selectedCityName: selectedCityName ?? this.selectedCityName,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, weather, selectedCityName, errorMessage];
}
