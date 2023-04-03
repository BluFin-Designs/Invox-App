import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsGraph extends StatelessWidget {
  const StatisticsGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xffC1C1C1),
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
                  maxY: 6,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(1, 3),
                        FlSpot(2, 2),
                        FlSpot(3, 5),
                        FlSpot(4, 3.1),
                        FlSpot(5, 4),
                        FlSpot(6, 3),
                        FlSpot(7, 4),
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
          Color.fromRGBO(255, 178, 107, 0),
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
      child: Text(value.toInt().toString(), style: style),
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
