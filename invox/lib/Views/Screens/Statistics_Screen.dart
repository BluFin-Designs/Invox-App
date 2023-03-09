import 'package:flutter/material.dart';

import '../Widgets/Statistics_LineGraph.dart';
import '../Widgets/StatisticsCard.dart';
import '../Widgets/Statistics_PieChart.dart';

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
        padding: const EdgeInsets.only(left: 22.0, right: 22.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 22.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  height: 86.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFFF0F0F0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFC1C1C1),
                        blurRadius: 4,
                        offset: Offset(4, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            "Amount",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 24.0,
                      ),
                      Text(
                        "₹ 20000.00",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 32.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 22.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: StatisticsGraph(),
              ),
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: StatisticsCard(
                      text: details[index]["Category"],
                      amount: details[index]["value"],
                      icon: details[index]["icon"],
                      color: details[index]["color"],
                    ),
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
