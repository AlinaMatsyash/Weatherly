import 'package:intl/intl.dart';

abstract final class DateFormatter {
  static String hour(DateTime value) {
    return DateFormat.Hm().format(value);
  }

  static String dayMonth(DateTime value) {
    return DateFormat('EEE d MMM').format(value);
  }
}
