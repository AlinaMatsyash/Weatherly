import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app/di/service_locator.dart';
import 'app/weatherly_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  await MobileAds.instance.initialize();

  runApp(const WeatherlyApp());
}
