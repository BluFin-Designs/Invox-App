import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invox/Models/Transaction_Model.dart';

import '../../Models/CategoryModel.dart';
import '../../blocs/categories_bloc.dart';
import '../Widgets/StatisticsCard.dart';
import '../Widgets/Statistics_LineGraph.dart';
import '../Widgets/Statistics_PieChart.dart';
import '../Widgets/Total_Balance_Card.dart';

class Statistics extends StatefulWidget {
  static const routeName = '/statisics';
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

double totalAmount = 0;

// get categorised transactions.
Future<Map<String, StatisticsModel>>? _getCategorisedAmount(
  List<TransactionCategoryModel> categories,
  List<TransactionModel> transactions,
) async {
  totalAmount = 0;
  Map<String, StatisticsModel> allCategoryAmount = {};
  for (TransactionCategoryModel cat in categories) {
    double tempTotal = 0;
    for (TransactionModel txn in transactions) {
      if (txn.category.Uid == cat.Uid) {
        tempTotal += txn.amount!;
      }
    }
    allCategoryAmount.putIfAbsent(
      cat.Uid,
      () => StatisticsModel(
        title: cat.title,
        amount: tempTotal,
        color: cat.color,
        icon: cat.icon,
      ),
    );
  }

  allCategoryAmount.forEach((key, value) {
    totalAmount += value.amount;
  });

  return allCategoryAmount;
}

class _StatisticsState extends State<Statistics> {
  List<Map> details = [
    {
      "Category": "Essential Items",
      "value": 8400.00,
      "color": const Color(0xff5269B3),
      "icon": Icons.label_important
    },
    {
      "Category": "Entertainment",
      "value": 6600.00,
      "color": const Color(0xff8EA7E9),
      "icon": Icons.movie_creation
    },
    {
      "Category": "Others",
      "value": 5000.00,
      "color": const Color(0xff91D8E4),
      "icon": Icons.male_sharp
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<TransactionModel> txns =
        ModalRoute.of(context)?.settings.arguments as List<TransactionModel>;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Statistics"),
        // centerTitle: false,
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesInitialState) {
            BlocProvider.of<CategoriesBloc>(context)
                .add(CategoriesLoadingEvent());
            return SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CategoriesLoadedState) {
            List<TransactionCategoryModel> allCategories = state.allCategories;
            return FutureBuilder(
              future: _getCategorisedAmount(allCategories, txns),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  debugPrint(snapshot.data.toString());
                  List<StatisticsModel> statsData =
                      (snapshot.data as Map<String, StatisticsModel>)
                          .values
                          .toList();
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 22.0,
                          ),
                          Total_Balance_Card(
                            amount: totalAmount,
                          ),
                          const SizedBox(
                            height: 22.0,
                          ),
                          const StatisticsGraph(),
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
                            stats:
                                snapshot.data as Map<String, StatisticsModel>,
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return StatisticsCard(
                                text: statsData[index].title,
                                amount: statsData[index].amount,
                                icon: IconData(statsData[index].icon,
                                    fontFamily: 'MaterialIcons'),
                                color: Color(statsData[index].color),
                              );
                            },
                            itemCount: details.length,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  debugPrint(snapshot.data.toString());
                  return const Center(
                    child: Text("Failed to load data!"),
                  );
                }
              },
            );
          } else {
            return SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Text("Error Loading Data!"),
              ),
            );
          }
        },
      ),
    );
  }
}

// All TxnStatisticsModel
class StatisticsModel {
  String title;
  double amount;
  int icon;
  int color;

  StatisticsModel({
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
  });
}
