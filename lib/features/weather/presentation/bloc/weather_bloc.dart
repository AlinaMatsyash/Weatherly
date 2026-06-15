import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/usecases/get_weather_by_city.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required GetWeatherByCity getWeatherByCity})
    : _getWeatherByCity = getWeatherByCity,
      super(const WeatherState()) {
    on<WeatherStarted>(_onStarted);
    on<WeatherRefreshRequested>(_onRefreshRequested);
  }

  final GetWeatherByCity _getWeatherByCity;

  Future<void> _onStarted(
    WeatherStarted event,
    Emitter<WeatherState> emit,
  ) async {
    if (state.status == WeatherStatus.loading &&
        state.selectedCityName == event.cityName) {
      return;
    }

    await _loadCity(event.cityName, emit);
  }

  Future<void> _onRefreshRequested(
    WeatherRefreshRequested event,
    Emitter<WeatherState> emit,
  ) async {
    await _loadCity(state.selectedCityName, emit);
  }

  Future<void> _loadCity(String cityName, Emitter<WeatherState> emit) async {
    emit(
      state.copyWith(
        status: WeatherStatus.loading,
        selectedCityName: cityName,
        clearError: true,
      ),
    );

    try {
      final weather = await _getWeatherByCity(cityName);

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          weather: weather,
          selectedCityName: weather.location.name,
          clearError: true,
        ),
      );
    } on WeatherException catch (error) {
      emit(
        state.copyWith(
          status: WeatherStatus.failure,
          errorMessage: error.failure.message,
        ),
      );
    } on Object catch (error) {
      emit(
        state.copyWith(
          status: WeatherStatus.failure,
          errorMessage: 'Weather loading failed: $error',
        ),
      );
    }
  }
}
