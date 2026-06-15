import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../design_system/theme/weatherly_colors.dart';
import '../../../design_system/tokens/app_radius.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../ad_ids.dart';

class HomeBottomBannerAd extends StatefulWidget {
  const HomeBottomBannerAd({super.key});

  @override
  State<HomeBottomBannerAd> createState() => _HomeBottomBannerAdState();
}

class _HomeBottomBannerAdState extends State<HomeBottomBannerAd> {
  BannerAd? _ad;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    if (AdIds.canShowHomeBottomBanner) {
      _loadAd();
    }
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  void _loadAd() {
    final ad = BannerAd(
      adUnitId: AdIds.homeBottomBanner,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }

          setState(() {
            _ad = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
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

    final colors = Theme.of(context).weatherlyColors;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.82),
        borderRadius: AppRadius.largeBorder,
        border: Border.all(color: colors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.xs,
              bottom: AppSpacing.xs,
            ),
            child: Text('Ad', style: Theme.of(context).textTheme.bodySmall),
          ),
          Center(
            child: SizedBox(
              width: ad.size.width.toDouble(),
              height: ad.size.height.toDouble(),
              child: AdWidget(ad: ad),
            ),
          ),
        ],
      ),
    );
  }
}
