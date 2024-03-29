import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SummaryCard extends StatelessWidget {
  SummaryCard({required this.credit, required this.debit});
  final double credit;
  final double debit;

  @override
  Widget build(BuildContext context) {
    double _percentage = ((credit) / (credit + debit)) * 100;
    return Container(
      height: 142.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffF0F5FF),
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
                      color: Color(0xFF91D8E4),
                      value: (credit != 0 || debit != 0) ? _percentage : 100,
                      showTitle: true,
                      title: (credit != 0 || debit != 0)
                          ? ('${(_percentage).toStringAsFixed(0)}%')
                          : 0.toString(),
                      titleStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          fontStyle: FontStyle.italic),
                      radius: 22.0),
                  PieChartSectionData(
                      color: Theme.of(context).primaryColor,
                      value:
                          (credit != 0 || debit != 0) ? 100 - _percentage : 0,
                      showTitle: true,
                      title: (credit != 0 || debit != 0)
                          ? ('${(100 - _percentage).toStringAsFixed(0)}%')
                          : 0.toString(),
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
                  color: Color(0xFF91D8E4),
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
