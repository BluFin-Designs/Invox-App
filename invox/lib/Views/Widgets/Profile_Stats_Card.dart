import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfileStatsCard extends StatelessWidget {
  final Color color_1;
  final Color color_2;
  final double value_1;
  final double value_2;

  const ProfileStatsCard({
    Key? key,
    required this.value_1,
    required this.value_2,
    required this.color_1,
    required this.color_2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _percentage = ((value_2 - value_1) / value_2) * 100;
    return Container(
      height: 240,
      width: 170,
      decoration: BoxDecoration(
        color: color_1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "MONTHLY BUDGET BALANCE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 140,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      startDegreeOffset: -90,
                      sectionsSpace: 0,
                      centerSpaceRadius: 37,
                      sections: [
                        PieChartSectionData(
                            color: Colors.white,
                            value: _percentage,
                            showTitle: false,
                            radius: 19.0),
                        PieChartSectionData(
                            color: color_2,
                            value: 100 - _percentage,
                            showTitle: false,
                            radius: 3.0),
                      ],
                    ),
                  ),
                ),
                Text(
                  '${_percentage.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "₹ ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                "${value_1.toStringAsFixed(0)} ",
                style: TextStyle(
                  color: color_2,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                "of ${value_2.toStringAsFixed(0)}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
