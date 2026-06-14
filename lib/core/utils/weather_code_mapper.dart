abstract final class WeatherCodeMapper {
  static String label(int code) {
    return switch (code) {
      0 => 'Clear Sky',
      1 || 2 => 'Partly Cloudy',
      3 => 'Cloudy',
      45 || 48 => 'Fog',
      51 || 53 || 55 => 'Drizzle',
      56 || 57 => 'Freezing Drizzle',
      61 || 63 || 65 => 'Rain',
      66 || 67 => 'Freezing Rain',
      71 || 73 || 75 => 'Snow',
      77 => 'Snow Grains',
      80 || 81 || 82 => 'Rain Showers',
      85 || 86 => 'Snow Showers',
      95 => 'Thunderstorm',
      96 || 99 => 'Thunderstorm With Hail',
      _ => 'Unknown',
    };
  }

  static String iconKey(int code, {required bool isDay}) {
    if (code == 0) {
      return isDay ? 'sun' : 'moon';
    }

    if (code >= 1 && code <= 3) {
      return isDay ? 'cloud_sun' : 'cloud_moon';
    }

    if (code == 45 || code == 48) {
      return 'fog';
    }

    if ((code >= 51 && code <= 67) || (code >= 80 && code <= 82)) {
      return 'rain';
    }

    if ((code >= 71 && code <= 77) || code == 85 || code == 86) {
      return 'snow';
    }

    if (code >= 95) {
      return 'storm';
    }

    return 'cloud';
  }
}
