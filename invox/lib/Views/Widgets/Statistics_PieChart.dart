import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPieChart extends StatelessWidget {
  List stats;

  StatisticsPieChart({
    super.key,
    required this.stats,
  });

  double getTotal() {
    double total = 0;
    for (int i = 0; i < stats.length; i++) {
      total = total + stats[i]["value"];
    }
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
    for (var element in stats) {
      data.add(PieChartSectionData(
          color: element["color"],
          value: element["value"],
          showTitle: true,
          title:
              ('${((element["value"] / getTotal()) * 100).toStringAsFixed(0)}%'),
          titleStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              fontStyle: FontStyle.italic),
          radius: 50.0));
    }
    return data;
  }
}
