import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:invox/Views/Widgets/weekly_chart.dart';

import '../../Models/Transaction_Model.dart';

class HomePageGraph extends StatefulWidget {
  final List<TransactionModel> transactions;

  const HomePageGraph({Key? key, required this.transactions}) : super(key: key);

  @override
  State<HomePageGraph> createState() => _HomePageGraphState();
}

List<TransactionModel>? allTransactions;

class _HomePageGraphState extends State<HomePageGraph> {
  @override
  void initState() {
    allTransactions = widget.transactions;
    super.initState();
  }

  Future<Map<String, List<TransactionModel>>>? _getWeeklyTransactions() async {
    Map<String, List<TransactionModel>> dailyTransactions = {
      'Monday': [],
      'Tuesday': [],
      'Wednesday': [],
      'Thursday': [],
      'Friday': [],
      'Saturday': [],
      'Sunday': [],
    };

    DateTime today = DateTime.now();
    DateTime lastSevenDays = today.subtract(const Duration(days: 6));

    for (var transaction in allTransactions!) {
      DateTime currentDate = transaction.date as DateTime;

      if (currentDate.isAfter(lastSevenDays) ||
          currentDate.isAtSameMomentAs(lastSevenDays)) {
        String dayOfWeek = DateFormat('EEEE').format(currentDate);
        dailyTransactions[dayOfWeek]?.add(transaction);
      }
    }
    return dailyTransactions;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  FutureBuilder<Map<String, List<TransactionModel>>>(
                      future: _getWeeklyTransactions(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Display a loading indicator while calculations are in progress
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          // Handle any errors that occurred during calculations
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          if (snapshot.data != null) {
                            return WeeklyChart(
                              transactions: snapshot.data
                                  as Map<String, List<TransactionModel>>,
                            );
                          } else {
                            return const Center(
                              child: Text('No transactions Yet :('),
                            );
                          }
                        }
                      }),
                  AspectRatio(
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
                                    TextStyle(
                                      color: Theme.of(context).primaryColor,
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
                  AspectRatio(
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
                                    TextStyle(
                                      color: Theme.of(context).primaryColor,
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
                ]),
          ),
          Container(
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xff8EA7E9),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 14,
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                tabs: const [
                  Text(
                    "Weekly",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Monthly",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Yearly",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
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
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
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
