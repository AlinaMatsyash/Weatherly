import 'package:flutter_test/flutter_test.dart';
import 'package:weatherly/core/utils/weather_code_mapper.dart';

void main() {
  group('WeatherCodeMapper', () {
    test('maps common weather codes to labels', () {
      expect(WeatherCodeMapper.label(0), 'Clear Sky');
      expect(WeatherCodeMapper.label(2), 'Partly Cloudy');
      expect(WeatherCodeMapper.label(61), 'Rain');
      expect(WeatherCodeMapper.label(95), 'Thunderstorm');
    });

    test('maps codes to icon keys', () {
      expect(WeatherCodeMapper.iconKey(0, isDay: true), 'sun');
      expect(WeatherCodeMapper.iconKey(0, isDay: false), 'moon');
      expect(WeatherCodeMapper.iconKey(61, isDay: true), 'rain');
      expect(WeatherCodeMapper.iconKey(95, isDay: true), 'storm');
    });
  });
}
