import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../Models/SavingGoalsModel.dart';

class SavingGoalsCard extends StatelessWidget {
  final SavingGoalsModel goal;
  const SavingGoalsCard({Key? key, required this.goal}) : super(key: key);
  double getSavingTotal(SavingGoalsModel goal) {
    double total = 0;
    for (int i = 0; i < goal.txn.length; i++) {
      total = total + goal.txn[i].amount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double _percentage = (getSavingTotal(goal) / goal.requiredAmount) * 100;
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
            goal.title,
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
