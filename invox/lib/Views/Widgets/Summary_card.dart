import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SummaryCard extends StatelessWidget {
  SummaryCard({required this.credit, required this.debit});
  final double credit;
  final double debit;

  @override
  Widget build(BuildContext context) {
    double _percentage = ((credit - debit) / credit) * 100;
    return Container(
      height: 142.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFC1C1C1),
            blurRadius: 4,
            offset: Offset(4, 4), // Shadow position
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                startDegreeOffset: -90,
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                      color: Color(0xFFA5C000),
                      value: _percentage,
                      showTitle: false,
                      radius: 20.0),
                  PieChartSectionData(
                      color: Theme.of(context).primaryColor,
                      value: 100 - _percentage,
                      showTitle: false,
                      radius: 20.0),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 35.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Credits",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "₹ ${credit.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFA5C000),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Debits",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "₹ ${debit.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
