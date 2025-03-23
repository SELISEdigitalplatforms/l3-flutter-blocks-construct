import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';

class DonutChart extends StatelessWidget {
  final double total;
  final Map<String, double> dataMap;
  final Map<String, Color> colorMap;

  const DonutChart({
    super.key,
    required this.total,
    required this.dataMap,
    required this.colorMap,
  });

  @override
  Widget build(BuildContext context) {
    final sections = dataMap.entries.map((entry) {
      final platform = entry.key;
      final value = entry.value;
      final color = colorMap[platform] ?? AppColors.neutral90;

      return PieChartSectionData(
        value: value,
        color: color,
        radius: 40,
        showTitle: false,
      );
    }).toList();

    return PieChart(
      PieChartData(
        sections: sections,
        sectionsSpace: 2,
        centerSpaceRadius: 80,
      ),
    );
  }
}
