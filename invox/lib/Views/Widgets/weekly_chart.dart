import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../Models/Transaction_Model.dart';

class WeeklyChart extends StatelessWidget {
  Map<String, List<TransactionModel>> transactions;

  WeeklyChart({
    required this.transactions,
    super.key,
  });

  final List<String> _days = [
    "",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  double maxValue = 0;
  List<double> alltotals = [];

  void _getAllTotals() {
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      double totalValue = 0;
      if (transactions[_days[today.subtract(Duration(days: i)).weekday]] !=
          null) {
        for (TransactionModel element in transactions[
            _days[today.subtract(Duration(days: i)).weekday]]!) {
          totalValue += element.amount!;
        }
      } else {
        totalValue = 0;
      }

      if (totalValue > maxValue) {
        maxValue = totalValue;
        alltotals.add(totalValue);
      } else {
        alltotals.add(totalValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _getAllTotals();
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffF0F5FF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: BarChart(
            BarChartData(
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                      width: 20,
                      toY: alltotals[6],
                      gradient: _barsGradient,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    )
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      toY: alltotals[5],
                      width: 20,
                      gradient: _barsGradient,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    )
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                      width: 20,
                      toY: alltotals[4],
                      gradient: _barsGradient,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    )
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(
                      width: 20,
                      toY: alltotals[3],
                      gradient: _barsGradient,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    )
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 4,
                  barRods: [
                    BarChartRodData(
                      width: 20,
                      toY: alltotals[2],
                      gradient: _barsGradient,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    )
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 5,
                  barRods: [
                    BarChartRodData(
                      width: 20,
                      toY: alltotals[1],
                      gradient: _barsGradient,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    )
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 6,
                  barRods: [
                    BarChartRodData(
                      width: 20,
                      toY: alltotals[0],
                      gradient: _barsGradient,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    )
                  ],
                  showingTooltipIndicators: [0],
                ),
              ],
              gridData: FlGridData(
                drawHorizontalLine: true,
                horizontalInterval: maxValue / 5,
                drawVerticalLine: false,
              ),
              alignment: BarChartAlignment.spaceAround,
              maxY: maxValue + (maxValue * 0.5),
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipPadding: EdgeInsets.zero,
                  tooltipMargin: 8,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      (rod.toY != 0) ? rod.toY.round().toString() : '',
                      const TextStyle(
                        color: Color(0xFF7286D3),
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: titlesData,
              borderData: FlBorderData(
                show: true,
                border: const Border(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Color.fromRGBO(114, 134, 211, .2),
          Color(0xFF7286D3),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    DateTime today = DateTime.now();
    final List<String> _days = [
      "",
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat",
      "Sun"
    ];
    switch (value.toInt()) {
      case 0:
        text = _days[today.subtract(const Duration(days: 6)).weekday];
        break;
      case 1:
        text = _days[today.subtract(const Duration(days: 5)).weekday];
        break;
      case 2:
        text = _days[today.subtract(const Duration(days: 4)).weekday];
        break;
      case 3:
        text = _days[today.subtract(const Duration(days: 3)).weekday];
        break;
      case 4:
        text = _days[today.subtract(const Duration(days: 2)).weekday];
        break;
      case 5:
        text = _days[today.subtract(const Duration(days: 1)).weekday];
        break;
      case 6:
        text = _days[today.weekday];
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );
}
