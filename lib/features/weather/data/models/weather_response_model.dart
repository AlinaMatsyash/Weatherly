import '../../../../core/utils/weather_code_mapper.dart';
import '../../../cities/domain/entities/city.dart';
import '../../domain/entities/air_quality.dart';
import '../../domain/entities/current_weather.dart';
import '../../domain/entities/daily_weather.dart';
import '../../domain/entities/hourly_weather.dart';
import '../../domain/entities/precipitation.dart';
import '../../domain/entities/weather.dart';

class WeatherResponseModel {
  const WeatherResponseModel({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) {
    return WeatherResponseModel(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      timezone: json['timezone'] as String? ?? 'UTC',
      current: CurrentWeatherModel.fromJson(
        json['current'] as Map<String, dynamic>? ?? {},
      ),
      hourly: HourlyWeatherModel.listFromJson(
        json['hourly'] as Map<String, dynamic>? ?? {},
      ),
      daily: DailyWeatherModel.listFromJson(
        json['daily'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  final double latitude;
  final double longitude;
  final String timezone;
  final CurrentWeatherModel current;
  final List<HourlyWeatherModel> hourly;
  final List<DailyWeatherModel> daily;

  Weather toEntity({required City location, AirQuality? airQuality}) {
    final hourlyEntities = hourly.map((item) => item.toEntity()).toList();

    return Weather(
      location: location,
      latitude: latitude,
      longitude: longitude,
      timezone: timezone,
      current: current.toEntity(),
      hourly: hourlyEntities,
      daily: daily.map((item) => item.toEntity()).toList(),
      precipitation: PrecipitationSummaryBuilder.fromHourly(hourlyEntities),
      airQuality: airQuality,
      lastUpdated: DateTime.now(),
    );
  }
}

class CurrentWeatherModel {
  const CurrentWeatherModel({
    required this.time,
    required this.temperature,
    required this.feelsLike,
    required this.conditionCode,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.uvIndex,
    required this.isDay,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      time: _date(json['time']),
      temperature: _double(json['temperature_2m']),
      feelsLike: _double(json['apparent_temperature']),
      conditionCode: _int(json['weather_code']),
      humidity: _int(json['relative_humidity_2m']),
      windSpeed: _double(json['wind_speed_10m']),
      windDirection: _int(json['wind_direction_10m']),
      uvIndex: _double(json['uv_index']),
      isDay: _int(json['is_day']) == 1,
    );
  }

  final DateTime time;
  final double temperature;
  final double feelsLike;
  final int conditionCode;
  final int humidity;
  final double windSpeed;
  final int windDirection;
  final double uvIndex;
  final bool isDay;

  CurrentWeather toEntity() {
    return CurrentWeather(
      time: time,
      temperature: temperature,
      feelsLike: feelsLike,
      conditionCode: conditionCode,
      conditionLabel: WeatherCodeMapper.label(conditionCode),
      iconKey: WeatherCodeMapper.iconKey(conditionCode, isDay: isDay),
      humidity: humidity,
      windSpeed: windSpeed,
      windDirection: windDirection,
      uvIndex: uvIndex,
      isDay: isDay,
    );
  }
}

class HourlyWeatherModel {
  const HourlyWeatherModel({
    required this.time,
    required this.temperature,
    required this.feelsLike,
    required this.conditionCode,
    required this.precipitationProbability,
    required this.precipitationAmount,
    required this.windSpeed,
    required this.uvIndex,
  });

  static List<HourlyWeatherModel> listFromJson(Map<String, dynamic> json) {
    final times = _list<String>(json['time']);

    return [
      for (var index = 0; index < times.length; index++)
        HourlyWeatherModel(
          time: _date(times[index]),
          temperature: _doubleAt(json['temperature_2m'], index),
          feelsLike: _doubleAt(json['apparent_temperature'], index),
          conditionCode: _intAt(json['weather_code'], index),
          precipitationProbability: _intAt(
            json['precipitation_probability'],
            index,
          ),
          precipitationAmount: _doubleAt(json['precipitation'], index),
          windSpeed: _doubleAt(json['wind_speed_10m'], index),
          uvIndex: _doubleAt(json['uv_index'], index),
        ),
    ];
  }

  final DateTime time;
  final double temperature;
  final double feelsLike;
  final int conditionCode;
  final int precipitationProbability;
  final double precipitationAmount;
  final double windSpeed;
  final double uvIndex;

  HourlyWeather toEntity() {
    return HourlyWeather(
      time: time,
      temperature: temperature,
      feelsLike: feelsLike,
      conditionCode: conditionCode,
      conditionLabel: WeatherCodeMapper.label(conditionCode),
      iconKey: WeatherCodeMapper.iconKey(conditionCode, isDay: true),
      precipitationProbability: precipitationProbability,
      precipitationAmount: precipitationAmount,
      windSpeed: windSpeed,
      uvIndex: uvIndex,
    );
  }
}

class DailyWeatherModel {
  const DailyWeatherModel({
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.conditionCode,
    required this.precipitationProbability,
    required this.precipitationSum,
    required this.uvIndex,
    required this.sunrise,
    required this.sunset,
  });

  static List<DailyWeatherModel> listFromJson(Map<String, dynamic> json) {
    final dates = _list<String>(json['time']);

    return [
      for (var index = 0; index < dates.length; index++)
        DailyWeatherModel(
          date: _date(dates[index]),
          minTemperature: _doubleAt(json['temperature_2m_min'], index),
          maxTemperature: _doubleAt(json['temperature_2m_max'], index),
          conditionCode: _intAt(json['weather_code'], index),
          precipitationProbability: _intAt(
            json['precipitation_probability_max'],
            index,
          ),
          precipitationSum: _doubleAt(json['precipitation_sum'], index),
          uvIndex: _doubleAt(json['uv_index_max'], index),
          sunrise: _dateAt(json['sunrise'], index),
          sunset: _dateAt(json['sunset'], index),
        ),
    ];
  }

  final DateTime date;
  final double minTemperature;
  final double maxTemperature;
  final int conditionCode;
  final int precipitationProbability;
  final double precipitationSum;
  final double uvIndex;
  final DateTime sunrise;
  final DateTime sunset;

  DailyWeather toEntity() {
    return DailyWeather(
      date: date,
      minTemperature: minTemperature,
      maxTemperature: maxTemperature,
      conditionCode: conditionCode,
      conditionLabel: WeatherCodeMapper.label(conditionCode),
      iconKey: WeatherCodeMapper.iconKey(conditionCode, isDay: true),
      precipitationProbability: precipitationProbability,
      precipitationSum: precipitationSum,
      uvIndex: uvIndex,
      sunrise: sunrise,
      sunset: sunset,
    );
  }
}

abstract final class PrecipitationSummaryBuilder {
  static PrecipitationSummary fromHourly(List<HourlyWeather> hourly) {
    final next24Hours = hourly.take(24).toList();
    final bars = [
      for (final item in next24Hours)
        PrecipitationBar(
          time: item.time,
          amount: item.precipitationAmount,
          probability: item.precipitationProbability,
        ),
    ];
    final rainyHours = next24Hours
        .where((item) => item.precipitationAmount > 0.1)
        .toList();

    if (rainyHours.isEmpty) {
      return PrecipitationSummary(
        startMessage: 'No rain expected',
        totalAmount: 0,
        intervals: const [],
        hourlyBars: bars,
      );
    }

    final total = rainyHours.fold<double>(
      0,
      (sum, item) => sum + item.precipitationAmount,
    );

    return PrecipitationSummary(
      startsAt: rainyHours.first.time,
      startMessage: _startMessage(rainyHours.first.time),
      totalAmount: double.parse(total.toStringAsFixed(1)),
      intervals: _intervals(rainyHours),
      hourlyBars: bars,
    );
  }

  static String _startMessage(DateTime startsAt) {
    final diff = startsAt.difference(DateTime.now());
    if (diff.inMinutes <= 0) {
      return 'Rain starting now';
    }

    if (diff.inMinutes < 60) {
      return 'Rain starting in ${diff.inMinutes} min';
    }

    return 'Rain starting in ${diff.inHours} h';
  }

  static List<PrecipitationInterval> _intervals(List<HourlyWeather> items) {
    final intervals = <PrecipitationInterval>[];
    var start = items.first;
    var previous = items.first;
    var currentIntensity = _intensity(start.precipitationAmount);
    var amount = start.precipitationAmount;

    for (final item in items.skip(1)) {
      final intensity = _intensity(item.precipitationAmount);
      final isContinuous = item.time.difference(previous.time).inHours <= 1;

      if (intensity != currentIntensity || !isContinuous) {
        intervals.add(
          PrecipitationInterval(
            start: start.time,
            end: previous.time.add(const Duration(hours: 1)),
            intensityLabel: currentIntensity,
            amount: double.parse(amount.toStringAsFixed(1)),
          ),
        );
        start = item;
        currentIntensity = intensity;
        amount = item.precipitationAmount;
      } else {
        amount += item.precipitationAmount;
      }

      previous = item;
    }

    intervals.add(
      PrecipitationInterval(
        start: start.time,
        end: previous.time.add(const Duration(hours: 1)),
        intensityLabel: currentIntensity,
        amount: double.parse(amount.toStringAsFixed(1)),
      ),
    );

    return intervals;
  }

  static String _intensity(double amount) {
    if (amount >= 4) return 'Heavy Rain';
    if (amount >= 1) return 'Moderate Rain';
    return 'Light Rain';
  }
}

DateTime _date(Object? value) {
  if (value is String) {
    return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }

  return DateTime.fromMillisecondsSinceEpoch(0);
}

DateTime _dateAt(Object? value, int index) {
  final values = _list<String>(value);
  if (index >= values.length) {
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  return _date(values[index]);
}

double _double(Object? value) {
  return (value as num?)?.toDouble() ?? 0;
}

int _int(Object? value) {
  return (value as num?)?.round() ?? 0;
}

double _doubleAt(Object? value, int index) {
  final values = _list<num>(value);
  if (index >= values.length) return 0;
  return values[index].toDouble();
}

int _intAt(Object? value, int index) {
  final values = _list<num>(value);
  if (index >= values.length) return 0;
  return values[index].round();
}

List<T> _list<T>(Object? value) {
  if (value is List) {
    return value.whereType<T>().toList();
  }

  return [];
}
