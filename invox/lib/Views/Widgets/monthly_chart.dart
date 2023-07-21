import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../Models/Transaction_Model.dart';

class MonthlyChart extends StatelessWidget {
  Map<int, List<TransactionModel>> transactions;

  MonthlyChart({
    required this.transactions,
    super.key,
  });

  double maxValue = 0;
  int widgetWidth = 0;

  List<BarChartGroupData> _getBarRods() {
    List<BarChartGroupData> currentMonthTransactions = [];
    DateTime today = DateTime.now();

    for (int i = 1; i <= 31; i++) {
      List<TransactionModel>? tempList = transactions[i];
      double totalValue = 0;
      if (tempList != null) {
        for (TransactionModel element in tempList) {
          totalValue += element.amount!;
        }
      } else {
        totalValue = 0;
      }

      if (totalValue > maxValue) {
        maxValue = totalValue;
      }

      currentMonthTransactions.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            width: (today.day < 20) ? widgetWidth / 35 : 10,
            toY: totalValue,
            gradient: _barsGradient,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          )
        ],
        showingTooltipIndicators: [1],
      ));
    }
    return currentMonthTransactions;
  }

  @override
  Widget build(BuildContext context) {
    widgetWidth = MediaQuery.of(context).size.width.toInt();
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
          padding: const EdgeInsets.all(8.0),
          child: BarChart(
            BarChartData(
              barGroups: _getBarRods(),
              gridData: FlGridData(
                drawHorizontalLine: true,
                drawVerticalLine: false,
                horizontalInterval: maxValue / 5,
              ),
              alignment: BarChartAlignment.spaceEvenly,
              maxY: maxValue + (maxValue * .5),
              barTouchData: BarTouchData(
                enabled: true,
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
                      (rod.toY > 0) ? rod.toY.round().toString() : "",
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
      fontSize: 12,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child:
          Text((value % 2 != 0) ? value.toInt().toString() : '', style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
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
