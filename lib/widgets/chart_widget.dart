import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartWidget extends StatelessWidget {
  final List<FlSpot> data;

  const ChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: true),
        minX: data.first.x,
        maxX: data.last.x,
        minY: data.map((e) => e.y).reduce((a, b) => a < b ? a : b),
        maxY: data.map((e) => e.y).reduce((a, b) => a > b ? a : b),
        lineBarsData: [
          LineChartBarData(
            spots: data,
            isCurved: true,
            colors: [Colors.blue],
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
