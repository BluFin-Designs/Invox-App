import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GoalsCard extends StatelessWidget {
  GoalsCard({Key? key}) : super(key: key);
  double amountSaved = 125000.00;
  double requiredAmount = 280000.00;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
              child: Text(
                'Your Savings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            '₹ ${amountSaved.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
            child: Container(
              height: 14,
              child: RotatedBox(
                quarterTurns: -3,
                child: AspectRatio(
                  aspectRatio: 0.05,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffF0F0F0),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: BarChart(
                        BarChartData(
                          barGroups: [
                            BarChartGroupData(
                              x: 0,
                              barRods: [
                                BarChartRodData(
                                  width: 10,
                                  toY: amountSaved,
                                  gradient: _barsGradient,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                ),
                              ],
                            ),
                          ],
                          gridData: FlGridData(
                              drawHorizontalLine: false,
                              drawVerticalLine: false),
                          alignment: BarChartAlignment.spaceAround,
                          maxY: requiredAmount,
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
                                    rod.toY.round().toString(),
                                    const TextStyle(
                                        color: Color(0xFFFF7B54),
                                        fontWeight: FontWeight.bold),
                                  );
                                },
                              )),
                          titlesData: titlesData,
                          borderData: FlBorderData(
                            show: true,
                            border: const Border(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '₹ ${amountSaved.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                '/ ₹ ${requiredAmount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Color(0xffFF7B54),
          Color(0xFF0A2647),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
  FlTitlesData get titlesData => FlTitlesData(
        show: false,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
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
