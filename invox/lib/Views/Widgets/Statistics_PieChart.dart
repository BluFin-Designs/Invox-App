import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../Screens/Statistics_Screen.dart';

class StatisticsPieChart extends StatelessWidget {
  Map<String, StatisticsModel> stats;

  StatisticsPieChart({
    super.key,
    required this.stats,
  });

  double getTotal() {
    double total = 0;
    stats.forEach((key, value) {
      total += value.amount;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
        aspectRatio: 1.7,
        child: PieChart(
          PieChartData(
            startDegreeOffset: -90,
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            sections: showingSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> data = [];
    stats.forEach((key, value) {
      data.add(PieChartSectionData(
          color: Color(value.color),
          value: value.amount,
          showTitle: true,
          title: ('${((value.amount / getTotal()) * 100).toStringAsFixed(0)}%'),
          titleStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              fontStyle: FontStyle.italic),
          radius: 50.0));
    });
    return data;
  }
}
