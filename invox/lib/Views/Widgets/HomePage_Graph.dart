import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePageGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 2,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xffF0F0F0),
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
                          toY: 8,
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
                          toY: 10,
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
                          toY: 14,
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
                          toY: 15,
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
                          toY: 13,
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
                          toY: 10,
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
                          toY: 16,
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
                    drawVerticalLine: false,
                  ),
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 20,
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
        ),
        Container(
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xffC1C1C1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 15.0,
                  ),
                  child: Text(
                    "Weekly",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  // color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 15.0,
                  ),
                  child: Text(
                    "Monthly",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  // color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 15.0,
                  ),
                  child: Text(
                    "Yearly",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Color.fromRGBO(255, 123, 84, .2),
          Color(0xFFFF7B54),
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
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thu';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
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
