import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/WalletModel.dart';
import '../Widgets/Total_Balance_Card.dart';
import '../Widgets/WalletSlider.dart';
import '../Widgets/Add_Wallet_PopUp.dart';
import '../../blocs/wallet_bloc.dart';
import '../../Repositories/WalletRepository.dart';

class MyWalletsScreen extends StatefulWidget {
  static const routeName = '/my_wallets';

  MyWalletsScreen({Key? key}) : super(key: key);

  State<MyWalletsScreen> createState() => _MyWalletsScreenState();
}

class _MyWalletsScreenState extends State<MyWalletsScreen> {
  void refreshPage() {
    setState(() {
      BlocProvider.of<WalletBloc>(context).add(WalletLoadingEvent());
    });
  }

  void delete(String uid) {
    setState(() {
      WalletRepository().deleteWallet(uid);
    });
  }
  /*WalletRepository walletRepo = WalletRepository();
  late List<Wallet> allWallets = walletRepo.getWallets();*/

  double getTotal(List<Wallet> allWallets) {
    double total = 0;
    for (int i = 0; i < allWallets.length; i++) {
      total = total + allWallets[i].amount;
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
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletInitialState) {
            BlocProvider.of<WalletBloc>(context).add(WalletLoadingEvent());
            return SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is WalletLoadedState) {
            List<Wallet> allWallets = state.allWallets;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Total_Balance_Card(amount: getTotal(allWallets)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF0F5FF),
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
                                    sections: showingSections(allWallets),
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
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (_, i) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                                color:
                                                    Color(allWallets[i].color),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            (allWallets[i].title.length > 13)
                                                ? '${allWallets[i].title.substring(0, 13)}..'
                                                : allWallets[i].title,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(allWallets[i].color),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: allWallets.length,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Wallet_Slider(
                    wallets: allWallets,
                    refresh: () => setState(() {
                      BlocProvider.of<WalletBloc>(context)
                          .add(WalletLoadingEvent());
                    }),
                    deleteFunction: delete,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 14,
                      ),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
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
                    onTap: () {
                      showDialog(
                        // barrierDismissible: false,
                        useSafeArea: true,
                        context: context,
                        builder: (_) => Dialog(
                          insetPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            height: MediaQuery.of(context).size.height - 500,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "New Wallet",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  AddWalletPopup(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ).then(
                        (value) => refreshPage(),
                      );
                    },
                  )
                ],
              ),
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

  List<PieChartSectionData> showingSections(List<Wallet> allWallets) {
    List<PieChartSectionData> data = [];
    for (var element in allWallets) {
      data.add(PieChartSectionData(
          color: Color(element.color),
          value: element.amount,
          showTitle: true,
          title:
              ('${((element.amount / getTotal(allWallets)) * 100).toStringAsFixed(0)}%'),
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
