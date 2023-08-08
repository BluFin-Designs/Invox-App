import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../Models/Transaction_Model.dart';

class StatisticsGraph extends StatelessWidget {
  final List<TransactionModel> allTransactions;
  StatisticsGraph({
    super.key,
    required this.allTransactions,
  });

  Map<String, double> graphValue = {
    "0": 0.0,
    "1": 0.0,
    "2": 0.0,
    "3": 0.0,
    "4": 0.0,
    "5": 0.0,
    "6": 0.0,
  };

  double maxValue = 0;

  DateTime today = DateTime.now();

  void _getAllTotals() {
    for (TransactionModel txn in allTransactions) {
      if (txn.txnType == TransactionType.DEBIT) {
        if (txn.date!.isAfter(today.subtract(const Duration(days: 1)))) {
          debugPrint(txn.date.toString());
          debugPrint(txn.amount.toString());
          graphValue["0"] = graphValue["0"]! + txn.amount!;
        } else if (txn.date!.isAfter(today.subtract(const Duration(days: 2))) &&
            txn.date!.isBefore(today.subtract(const Duration(days: 1)))) {
          debugPrint(txn.date.toString());
          debugPrint(txn.amount.toString());
          graphValue["1"] = graphValue["1"]! + txn.amount!;
        } else if (txn.date!.isAfter(today.subtract(const Duration(days: 3))) &&
            txn.date!.isBefore(today.subtract(const Duration(days: 2)))) {
          debugPrint(txn.date.toString());
          debugPrint(txn.amount.toString());
          graphValue["2"] = graphValue["2"]! + txn.amount!;
        } else if (txn.date!.isAfter(today.subtract(const Duration(days: 4))) &&
            txn.date!.isBefore(today.subtract(const Duration(days: 3)))) {
          debugPrint(txn.date.toString());
          debugPrint(txn.amount.toString());
          graphValue["3"] = graphValue["3"]! + txn.amount!;
        } else if (txn.date!.isAfter(today.subtract(const Duration(days: 5))) &&
            txn.date!.isBefore(today.subtract(const Duration(days: 4)))) {
          debugPrint(txn.date.toString());
          debugPrint(txn.amount.toString());
          graphValue["4"] = graphValue["4"]! + txn.amount!;
        } else if (txn.date!.isAfter(today.subtract(const Duration(days: 6))) &&
            txn.date!.isBefore(today.subtract(const Duration(days: 5)))) {
          debugPrint(txn.date.toString());
          debugPrint(txn.amount.toString());
          graphValue["5"] = graphValue["5"]! + txn.amount!;
        } else if (txn.date!.isAfter(today.subtract(const Duration(days: 7))) &&
            txn.date!.isBefore(today.subtract(const Duration(days: 6)))) {
          debugPrint(txn.date.toString());
          debugPrint(txn.amount.toString());
          graphValue["6"] = graphValue["6"]! + txn.amount!;
        }
      }
    }
    for (int i = 0; i < 7; i++) {
      if (graphValue[i.toString()]! > maxValue) {
        maxValue = graphValue[i.toString()]!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _getAllTotals();
    // debugPrint(graphValue["0"].toString());
    // debugPrint(graphValue["1"].toString());
    // debugPrint(graphValue["2"].toString());
    // debugPrint(graphValue["3"].toString());
    // debugPrint(graphValue["4"].toString());
    // debugPrint(graphValue["5"].toString());
    // debugPrint(graphValue["6"].toString());
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xff8EA7E9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: const Text(
            "Last 7 Days Spendings",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 2.2,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 40.0, right: 40.0),
              child: LineChart(
                LineChartData(
                  clipData: FlClipData.horizontal(),
                  titlesData: titlesData,
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(),
                  ),
                  gridData: FlGridData(
                    drawHorizontalLine: false,
                    drawVerticalLine: false,
                  ),
                  minX: 1,
                  minY: 0,
                  maxX: 7,
                  maxY: maxValue + 50,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(1, graphValue["0"]!),
                        FlSpot(2, graphValue["1"]!),
                        FlSpot(3, graphValue["2"]!),
                        FlSpot(4, graphValue["3"]!),
                        FlSpot(5, graphValue["4"]!),
                        FlSpot(6, graphValue["5"]!),
                        FlSpot(7, graphValue["6"]!),
                      ],
                      isCurved: true,
                      gradient: _barsGradient,
                      barWidth: 5,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: _barsGradient,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Color.fromRGBO(114, 134, 211, 0),
          Color(0xFFFFFFFF),
        ],
        end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontStyle: FontStyle.italic,
      fontSize: 14,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text((today.day - value.toInt() + 1).toString(), style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
            interval: 1,
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
