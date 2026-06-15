import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:weatherly/design_system/theme/weatherly_dark_theme.dart';
import 'package:weatherly/design_system/widgets/weather_metric_card.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('WeatherMetricCard renders metric content', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: WeatherlyDarkTheme.theme,
        home: Scaffold(
          body: WeatherMetricCard(
            title: 'Humidity',
            value: '62%',
            icon: PhosphorIcons.drop(PhosphorIconsStyle.duotone),
          ),
        ),
      ),
    );

    expect(find.text('Humidity'), findsOneWidget);
    expect(find.text('62%'), findsOneWidget);
  });
}
