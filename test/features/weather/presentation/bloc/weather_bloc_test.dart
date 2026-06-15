import 'package:flutter_test/flutter_test.dart';
import 'package:weatherly/features/weather/domain/usecases/get_weather_by_city.dart';
import 'package:weatherly/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weatherly/features/weather/presentation/bloc/weather_event.dart';
import 'package:weatherly/features/weather/presentation/bloc/weather_state.dart';

import '../../../../helpers/fake_weather_repository.dart';

void main() {
  group('WeatherBloc', () {
    test('loads weather for the requested city', () async {
      final repository = FakeWeatherRepository();
      final bloc = WeatherBloc(getWeatherByCity: GetWeatherByCity(repository));

      bloc.add(const WeatherStarted(cityName: 'San Francisco'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<WeatherState>().having(
            (state) => state.status,
            'status',
            WeatherStatus.loading,
          ),
          isA<WeatherState>()
              .having((state) => state.status, 'status', WeatherStatus.success)
              .having(
                (state) => state.weather?.location.name,
                'city name',
                'San Francisco',
              ),
        ]),
      );

      expect(repository.lastCityName, 'San Francisco');

      await bloc.close();
    });

    test('emits failure when repository throws', () async {
      final repository = FakeWeatherRepository(shouldFail: true);
      final bloc = WeatherBloc(getWeatherByCity: GetWeatherByCity(repository));

      bloc.add(const WeatherStarted(cityName: 'San Francisco'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<WeatherState>().having(
            (state) => state.status,
            'status',
            WeatherStatus.loading,
          ),
          isA<WeatherState>()
              .having((state) => state.status, 'status', WeatherStatus.failure)
              .having(
                (state) => state.errorMessage,
                'error',
                'Network unavailable.',
              ),
        ]),
      );

      await bloc.close();
    });
  });
}
