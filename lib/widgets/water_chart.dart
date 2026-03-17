import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/water_log.dart';

class WaterChart extends StatelessWidget {
  final List<WaterLog> logs;

  const WaterChart({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    final spots = logs.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.amount);
    }).toList();

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(spots: spots),
        ],
      ),
    );
  }
}