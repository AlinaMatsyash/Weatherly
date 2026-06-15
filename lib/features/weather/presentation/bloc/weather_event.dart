import 'package:equatable/equatable.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class WeatherStarted extends WeatherEvent {
  const WeatherStarted({this.cityName = 'San Francisco'});

  final String cityName;

  @override
  List<Object?> get props => [cityName];
}

class WeatherRefreshRequested extends WeatherEvent {
  const WeatherRefreshRequested();
}
