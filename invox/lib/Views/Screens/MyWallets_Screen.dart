import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../Widgets/Total_Balance_Card.dart';
import '../Widgets/WalletSlider.dart';

class MyWalletsScreen extends StatelessWidget {
  static const routeName = '/my_wallets';

  MyWalletsScreen({Key? key}) : super(key: key);

  List<Map<String, dynamic>> wallets = [
    {
      "name": "Cash",
      "value": 5000.0,
      "color": 0xffFF7B54,
    },
    {
      "name": "Bank Account",
      "value": 1000.0,
      "color": 0xffA5C000,
    },
    {
      "name": "Digital Wallet",
      "value": 500.0,
      "color": 0xffC1C1C1,
    },
    {
      "name": "Others",
      "value": 1000.0,
      "color": 0xffFFB26B,
    },
  ];

  double getTotal() {
    double total = 0;
    for (int i = 0; i < wallets.length; i++) {
      total = total + wallets[i]["value"];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wallets"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20,
              ),
              child: Total_Balance_Card(amount: 25000),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20,
              ),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffF0F0F0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 2,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        child: AspectRatio(
                          aspectRatio: 1.8,
                          child: PieChart(
                            PieChartData(
                              startDegreeOffset: -90,
                              sectionsSpace: 0,
                              centerSpaceRadius: 40,
                              sections: showingSections(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        width: 150,
                        child: Center(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (_, i) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                          color: Color(wallets[i]["color"]),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      (wallets[i]["name"].length > 13)
                                          ? '${wallets[i]["name"].substring(0, 13)}..'
                                          : wallets[i]["name"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(wallets[i]["color"]),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: wallets.length,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Wallet_Slider(wallets: wallets),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20,
                ),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius: 2,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Add Wallet",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> data = [];
    for (var element in wallets) {
      data.add(PieChartSectionData(
          color: Color(element["color"]),
          value: element["value"],
          showTitle: true,
          title:
              ('${((element["value"] / getTotal()) * 100).toStringAsFixed(0)}%'),
          titleStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              fontStyle: FontStyle.italic),
          radius: 40.0));
    }
    return data;
  }
}
