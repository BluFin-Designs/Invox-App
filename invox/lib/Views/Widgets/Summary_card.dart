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
                      showTitle: true,
                      title: ('${(_percentage).toStringAsFixed(0)}%'),
                      titleStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          fontStyle: FontStyle.italic),
                      radius: 22.0),
                  PieChartSectionData(
                      color: Theme.of(context).primaryColor,
                      value: 100 - _percentage,
                      showTitle: true,
                      title: ('${(100 - _percentage).toStringAsFixed(0)}%'),
                      titleStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          fontStyle: FontStyle.italic),
                      radius: 22.0),
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
