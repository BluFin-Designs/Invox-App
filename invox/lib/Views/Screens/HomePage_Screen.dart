import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './MyWallets_Screen.dart';
import './Profile_Screen.dart';
import './Statistics_Screen.dart';
import './Transaction_Screen.dart';
import '../Widgets/Add_Transaction_PopUp.dart';
import '../Widgets/Edit_Transaction_PopUp.dart';
import '../Widgets/HomePage_Graph.dart';
import '../Widgets/TransactionCard.dart';
import '../Widgets/MenuDrawer.dart';
import '../../Repositories/UserRepository.dart';
import '../../Repositories/TransactionRepository.dart';
import '../../Models/Transaction_Model.dart';
import '../../blocs/transactions_bloc.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    UserRepository();
    TransactionRepository().getTransactions();
    super.initState();
  }

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Image.asset(
          "assets/images/logo.png",
          height: 50,
          width: 80,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 30,
          ),
          onPressed: () => _key.currentState!.openDrawer(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.circle_notifications,
              size: 35,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 14,
              ),
              HomePageGraph(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Recent Transactions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Icon(Icons.tune),
                ],
              ),
              BlocBuilder<TransactionsBloc, TransactionsState>(
                builder: (context, state) {
                  if (state is TransactionsInitialState) {
                    BlocProvider.of<TransactionsBloc>(context)
                        .add(TransactionLoadingEvent());
                    return SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is TransactionsLoadedState) {
                    List<TransactionModel> allTxns = state.allTransactions;
                    if (allTxns.length != 0) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return Dismissible(
                              confirmDismiss: (direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  final bool res = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: const Text(
                                              "Are you sure you want to delete ?"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                            ),
                                            TextButton(
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                // TODO: Delete the item from DB etc..
                                                setState(() {
                                                  TransactionRepository
                                                          .deleteTransaction(
                                                              allTxns[index].uid
                                                                  as String)
                                                      .then(
                                                    (value) =>
                                                        Navigator.pop(context),
                                                  );
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                  return res;
                                } else {
                                  showDialog(
                                    barrierDismissible: false,
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) => Dialog(
                                      insetPadding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        height: 530,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: <Widget>[
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "Edit Transaction",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              EditTransactionPopUp(
                                                  txn: allTxns[index]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ).then((value) => setState(() {}));
                                }
                              },
                              background: slideRightBackground(),
                              secondaryBackground: slideLeftBackground(),
                              key: Key(allTxns[index].title as String),
                              child: TransactionCard(txn: allTxns[index]));
                        },
                        itemCount: allTxns.length,
                      );
                    } else {
                      return SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: Text("Oops, No Transactions yet!"),
                        ),
                      );
                    }
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
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: const Color(0xffF0F5FF),
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: BottomNavigationBar(
          onTap: (int x) {
            switch (x) {
              case 0:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return BlocProvider(
                        create: (context) => TransactionsBloc(),
                        child: Transaction(),
                      );
                    },
                  ),
                );
                break;
              case 1:
                Navigator.pushNamed(context, MyWalletsScreen.routeName);
                break;
              case 2:
                Navigator.pushNamed(context, Statistics.routeName);
                break;
              case 3:
                Navigator.pushNamed(context, Profile.routeName);
                break;
            }
          },
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: "Transactions",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_rounded),
              label: "Wallet",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart),
              label: "Statistics",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: "Profile",
            ),
          ],
        ),
      ),
      drawer: const MenuDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Image.asset(
          "assets/images/logo_icon.png",
          width: 35,
        ),
        onPressed: () {
          showDialog(
            // barrierDismissible: false,
            useSafeArea: true,
            context: context,
            builder: (_) => Dialog(
              insetPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height - 250,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "New Transaction",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const AddTransactionPopUp(),
                    ],
                  ),
                ),
              ),
            ),
          ).then((value) => setState(() {}));
        },
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.blueAccent,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.redAccent,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
