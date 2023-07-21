import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invox/Views/Widgets/monthly_chart.dart';
import 'package:invox/Views/Widgets/weekly_chart.dart';
import 'package:invox/Views/Widgets/yearly_chart.dart';

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
    _separateMonthlyTransactions();
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
        if (_isExpense && transaction.txnType == TransactionType.DEBIT) {
          dailyTransactions[dayOfWeek]?.add(transaction);
        } else if (!_isExpense &&
            transaction.txnType == TransactionType.CREDIT) {
          dailyTransactions[dayOfWeek]?.add(transaction);
        }
      }
    }
    return dailyTransactions;
  }

  // Monthly Transactions
  Future<Map<int, List<TransactionModel>>>?
      _separateMonthlyTransactions() async {
    Map<int, List<TransactionModel>> monthlyTransactions = {};

    for (var transaction in allTransactions!) {
      DateTime? currentDate = transaction.date;
      int? dayOfMonth = currentDate?.day;

      if (currentDate!.month == DateTime.now().month) {
        if (!monthlyTransactions.containsKey(dayOfMonth)) {
          monthlyTransactions[dayOfMonth!] = [];
        }
        if (_isExpense && transaction.txnType == TransactionType.DEBIT) {
          monthlyTransactions[dayOfMonth]!.add(transaction);
        } else if (!_isExpense &&
            transaction.txnType == TransactionType.CREDIT) {
          monthlyTransactions[dayOfMonth]!.add(transaction);
        }
      }
    }

    // debugPrint(monthlyTransactions.toString());
    // debugPrint(monthlyTransactions[19]![0].date.toString());

    return monthlyTransactions;
  }

  // Yearly Transaction data
  Future<Map<int, List<TransactionModel>>> _separateYearlyTransactions() async {
    Map<int, List<TransactionModel>> yearlyTransactions = {};

    for (TransactionModel transaction in allTransactions!) {
      DateTime currentDate = transaction.date!;
      int monthOfYear = currentDate.month;

      if (currentDate!.year == DateTime.now().year) {
        if (!yearlyTransactions.containsKey(monthOfYear)) {
          yearlyTransactions[monthOfYear] = [];
        }
        if (_isExpense && transaction.txnType == TransactionType.DEBIT) {
          yearlyTransactions[monthOfYear]!.add(transaction);
        } else if (!_isExpense &&
            transaction.txnType == TransactionType.CREDIT) {
          yearlyTransactions[monthOfYear]!.add(transaction);
        }
      }
    }

    return yearlyTransactions;
  }

  // variables
  bool _isExpense = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xff8EA7E9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Text(
                      _isExpense ? "Expense" : "Income",
                      style: TextStyle(
                        color: _isExpense ? Colors.red : Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 20,
                    child: Switch.adaptive(
                      activeColor: Colors.redAccent,
                      value: _isExpense,
                      onChanged: (val) {
                        setState(() {
                          _isExpense = val;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
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
                  FutureBuilder<Map<int, List<TransactionModel>>>(
                      future: _separateMonthlyTransactions(),
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
                            return MonthlyChart(
                              transactions: snapshot.data
                                  as Map<int, List<TransactionModel>>,
                            );
                          } else {
                            return const Center(
                              child: Text('No transactions Yet :('),
                            );
                          }
                        }
                      }),
                  FutureBuilder<Map<int, List<TransactionModel>>>(
                      future: _separateYearlyTransactions(),
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
                            return YearlyChart(
                              transactions: snapshot.data
                                  as Map<int, List<TransactionModel>>,
                            );
                          } else {
                            return const Center(
                              child: Text('No transactions Yet :('),
                            );
                          }
                        }
                      }),
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
