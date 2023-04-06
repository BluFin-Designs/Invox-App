import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SavingGoalsCard extends StatelessWidget {
  final double value_1;
  final double value_2;
  final String itemName;
  const SavingGoalsCard(
      {Key? key,
      required this.value_1,
      required this.value_2,
      required this.itemName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _percentage = ((value_2 - value_1) / value_2) * 100;
    return Container(
      height: 180,
      width: 172,
      decoration: BoxDecoration(
        color: const Color(0xFF8EA7E9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                            color: Theme.of(context).primaryColor,
                            value: 100 - _percentage,
                            showTitle: false,
                            radius: 3.0),
                      ],
                    ),
                  ),
                ),
                Text(
                  '${_percentage.toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            itemName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
