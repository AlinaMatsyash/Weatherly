import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../design_system/theme/weatherly_colors.dart';
import '../ad_ids.dart';

class HomeForecastNativeAd extends StatefulWidget {
  const HomeForecastNativeAd({super.key});

  @override
  State<HomeForecastNativeAd> createState() => _HomeForecastNativeAdState();
}

class _HomeForecastNativeAdState extends State<HomeForecastNativeAd> {
  NativeAd? _ad;
  bool _isLoaded = false;
  bool _didLoad = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_didLoad && AdIds.canShowHomeForecastNative) {
      _didLoad = true;
      _loadAd();
    }
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  void _loadAd() {
    final colors = Theme.of(context).weatherlyColors;
    final ad = NativeAd(
      adUnitId: AdIds.homeForecastNative,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }

          setState(() {
            _ad = ad as NativeAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
        mainBackgroundColor: colors.surface,
        cornerRadius: 24,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          backgroundColor: colors.primary,
          style: NativeTemplateFontStyle.bold,
          size: 14,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: colors.textPrimary,
          style: NativeTemplateFontStyle.bold,
          size: 15,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: colors.textSecondary,
          size: 13,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: colors.textTertiary,
          size: 12,
        ),
      ),
    );

    ad.load();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _ad;
    if (!_isLoaded || ad == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 150,
      width: double.infinity,
      child: AdWidget(ad: ad),
    );
  }
}
