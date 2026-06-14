import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../theme/weatherly_colors.dart';
import '../tokens/app_spacing.dart';

class PrecipitationChart extends StatelessWidget {
  const PrecipitationChart({
    required this.values,
    required this.labels,
    super.key,
  });

  final List<double> values;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.weatherlyColors;
    final maxValue = values.fold<double>(1, (max, value) {
      return value > max ? value : max;
    });

    return SizedBox(
      height: 124,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          maxY: maxValue + 1,
          minY: 0,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(),
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  final shouldShow =
                      index >= 0 &&
                      index < labels.length &&
                      (index == 0 ||
                          index == labels.length ~/ 2 ||
                          index == labels.length - 1);

                  if (!shouldShow) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.xs),
                    child: Text(
                      labels[index],
                      style: theme.textTheme.labelMedium,
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: [
            for (var i = 0; i < values.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: values[i],
                    width: 6,
                    color: colors.rain,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
