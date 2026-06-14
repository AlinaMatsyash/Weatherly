import 'package:flutter/material.dart';

import '../theme/weatherly_colors.dart';
import '../tokens/app_radius.dart';
import '../tokens/app_spacing.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({this.message = 'Loading weather', super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).weatherlyColors;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 44,
            width: 44,
            child: CircularProgressIndicator(color: colors.primary),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(message, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).weatherlyColors;

    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: colors.surfaceElevated.withValues(alpha: 0.56),
        borderRadius: AppRadius.largeBorder,
        border: Border.all(color: colors.border),
      ),
    );
  }
}
