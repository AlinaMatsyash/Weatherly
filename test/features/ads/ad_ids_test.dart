import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weatherly/features/ads/ad_ids.dart';

void main() {
  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });

  test('uses Android Google test ad units outside release builds', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    expect(kReleaseMode, isFalse);
    expect(AdIds.homeBottomBanner, 'ca-app-pub-3940256099942544/6300978111');
    expect(AdIds.homeForecastNative, 'ca-app-pub-3940256099942544/2247696110');
    expect(AdIds.canShowHomeBottomBanner, isTrue);
    expect(AdIds.canShowHomeForecastNative, isTrue);
  });

  test('uses iOS Google test ad units outside release builds', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    expect(kReleaseMode, isFalse);
    expect(AdIds.homeBottomBanner, 'ca-app-pub-3940256099942544/2934735716');
    expect(AdIds.homeForecastNative, 'ca-app-pub-3940256099942544/3986624511');
    expect(AdIds.canShowHomeBottomBanner, isTrue);
    expect(AdIds.canShowHomeForecastNative, isTrue);
  });
}
