abstract final class UnitConverter {
  static double celsiusToFahrenheit(double value) {
    return (value * 9 / 5) + 32;
  }

  static double kilometersPerHourToMetersPerSecond(double value) {
    return value / 3.6;
  }

  static double millimetersToInches(double value) {
    return value / 25.4;
  }
}
