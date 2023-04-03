import 'package:flutter/material.dart';

import '../Widgets/Statistics_LineGraph.dart';
import '../Widgets/StatisticsCard.dart';
import '../Widgets/Statistics_PieChart.dart';
import '../Widgets/Total_Balance_Card.dart';

class Statistics extends StatefulWidget {
  static const routeName = '/statisics';
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<Map> details = [
    {
      "Category": "Essential Items",
      "value": 8400.00,
      "color": Colors.black,
      "icon": Icons.label_important
    },
    {
      "Category": "Entertainment",
      "value": 6600.00,
      "color": Colors.deepOrangeAccent,
      "icon": Icons.movie_creation
    },
    {
      "Category": "Others",
      "value": 5000.00,
      "color": Colors.blueAccent,
      "icon": Icons.male_sharp
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Statistics"),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 22.0,
              ),
              Total_Balance_Card(
                amount: 2000,
              ),
              const SizedBox(
                height: 22.0,
              ),
              StatisticsGraph(),
              const SizedBox(
                height: 18.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "Spending Breakups",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              StatisticsPieChart(
                stats: details,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return StatisticsCard(
                    text: details[index]["Category"],
                    amount: details[index]["value"],
                    icon: details[index]["icon"],
                    color: details[index]["color"],
                  );
                },
                itemCount: details.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
