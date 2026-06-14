import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherly/app/weatherly_app.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('Weatherly app starts on the home screen', (tester) async {
    await tester.pumpWidget(const WeatherlyApp());
    await tester.pumpAndSettle();

    expect(find.text('San Francisco'), findsOneWidget);
    expect(find.text('Hourly Forecast'), findsOneWidget);
    expect(find.text('7-Day Forecast'), findsOneWidget);
  });
}
