import 'package:flutter/foundation.dart';

abstract final class AdIds {
  static bool get canShowHomeBottomBanner {
    if (!kReleaseMode) {
      return _isSupportedMobilePlatform;
    }

    return _isAndroid;
  }

  static bool get canShowHomeForecastNative {
    if (!kReleaseMode) {
      return _isSupportedMobilePlatform;
    }

    return _isAndroid;
  }

  static String get homeBottomBanner {
    if (kReleaseMode && _isAndroid) {
      return _androidHomeBottomBanner;
    }

    if (_isIos) {
      return _iosTestBanner;
    }

    return _androidTestBanner;
  }

  static String get homeForecastNative {
    if (kReleaseMode && _isAndroid) {
      return _androidHomeForecastNative;
    }

    if (_isIos) {
      return _iosTestNative;
    }

    return _androidTestNative;
  }

  static const _androidHomeBottomBanner =
      'ca-app-pub-5218177686730446/1046361071';
  static const _androidHomeForecastNative =
      'ca-app-pub-5218177686730446/4427498036';

  static const _androidTestBanner = 'ca-app-pub-3940256099942544/6300978111';
  static const _androidTestNative = 'ca-app-pub-3940256099942544/2247696110';
  static const _iosTestBanner = 'ca-app-pub-3940256099942544/2934735716';
  static const _iosTestNative = 'ca-app-pub-3940256099942544/3986624511';

  static bool get _isSupportedMobilePlatform => _isAndroid || _isIos;
  static bool get _isAndroid => defaultTargetPlatform == TargetPlatform.android;
  static bool get _isIos => defaultTargetPlatform == TargetPlatform.iOS;
}
