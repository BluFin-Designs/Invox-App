import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './MyWallets_Screen.dart';
import './Profile_Screen.dart';
import './Statistics_Screen.dart';
import './Transaction_Screen.dart';
import '../../Models/Transaction_Model.dart';
import '../../Repositories/TransactionRepository.dart';
import '../../Repositories/UserRepository.dart';
import '../../blocs/transactions_bloc.dart';
import '../../blocs/wallet_bloc.dart';
import '../Widgets/Add_Transaction_PopUp.dart';
import '../Widgets/Edit_Transaction_PopUp.dart';
import '../Widgets/HomePage_Graph.dart';
import '../Widgets/MenuDrawer.dart';
import '../Widgets/TransactionCard.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Filter { CREDIT, DEBIT, ALL }

class _HomePageState extends State<HomePage> {
  var txnInstance = TransactionRepository();
  final _key = GlobalKey<ScaffoldState>();
  late List<TransactionModel> allTxns;
  Filter _txnFilter = Filter.ALL;

  @override
  void initState() {
    UserRepository();
    // TransactionRepository().getTransactions();
    super.initState();
  }

  List<TransactionModel> getTransactions(List<TransactionModel> txns) {
    allTxns = [];
    for (TransactionModel txn in txns) {
      if (txn.txnType == TransactionType.CREDIT &&
          _txnFilter == Filter.CREDIT) {
        allTxns.add(txn);
      } else if (txn.txnType == TransactionType.DEBIT &&
          _txnFilter == Filter.DEBIT) {
        allTxns.add(txn);
      } else if (_txnFilter == Filter.ALL) {
        allTxns.add(txn);
      }
    }
    return allTxns;
  }

  void setFilter(Filter filter) {
    _txnFilter = filter;
  }

  _refresh() {
    setState(() {});
  }

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
      body: BlocBuilder<TransactionsBloc, TransactionsState>(
          builder: (ctx, state) {
        // print("Called!");
        // print(state);
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
          getTransactions(state.allTransactions);
          // print(allTxns);

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  HomePageGraph(
                    key: UniqueKey(),
                    transactions: allTxns,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recent Transactions",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (_) {
                                return FilterOption(
                                  filterGroup: _txnFilter,
                                  handleFilter: setFilter,
                                );
                              }).then((value) => _refresh());
                        },
                        icon: const Icon(Icons.tune),
                      ),
                    ],
                  ),
                  (allTxns.isNotEmpty)
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            return Dismissible(
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    showDialog(
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
                                                    txnInstance
                                                        .deleteTransaction(
                                                            allTxns[index].uid
                                                                as String)
                                                        .then((value) {
                                                      Navigator.pop(context);
                                                    });
                                                  });
                                                },
                                              ),
                                            ],
                                          );
                                        }).then(
                                      (value) =>
                                          BlocProvider.of<TransactionsBloc>(
                                                  context)
                                              .add(TransactionLoadingEvent()),
                                    );
                                  } else {
                                    showDialog(
                                      barrierDismissible: false,
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) => Dialog(
                                        insetPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          height: 600,
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
                                    ).then((value) => setState(() {
                                          BlocProvider.of<TransactionsBloc>(
                                                  context)
                                              .add(TransactionLoadingEvent());
                                        }));
                                  }
                                },
                                background: slideRightBackground(),
                                secondaryBackground: slideLeftBackground(),
                                key: Key(allTxns[index].title),
                                child: TransactionCard(txn: allTxns[index]));
                          },
                          itemCount:
                              (allTxns.length < 50) ? allTxns.length : 50,
                        )
                      : SizedBox(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Text("Oops, No Transactions yet!"),
                          ),
                        ),
                ],
              ),
            ),
          );
        } else {
          return SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Text("Something Went Wrong!"),
            ),
          );
        }
      }),
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
                        child: const Transaction(),
                      );
                    },
                  ),
                );
                break;
              case 1:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return BlocProvider(
                        create: (context) => WalletBloc(),
                        child: MyWalletsScreen(),
                      );
                    },
                  ),
                );
                break;
              case 2:
                Navigator.pushNamed(
                  context,
                  Statistics.routeName,
                  arguments: allTxns,
                );
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
          ).then((value) => setState(() {
                BlocProvider.of<TransactionsBloc>(context)
                    .add(TransactionLoadingEvent());
              }));
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

class FilterOption extends StatefulWidget {
  Filter filterGroup;
  Function handleFilter;

  FilterOption({
    required this.filterGroup,
    required this.handleFilter,
    super.key,
  });

  @override
  State<FilterOption> createState() => _FilterOptionState();
}

class _FilterOptionState extends State<FilterOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.all(16.0),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "All",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Radio(
                      value: Filter.ALL,
                      groupValue: widget.filterGroup,
                      onChanged: (value) => setState(
                        () {
                          widget.filterGroup = value as Filter;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Debit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    Radio(
                      value: Filter.DEBIT,
                      groupValue: widget.filterGroup,
                      onChanged: (value) => setState(
                        () {
                          widget.filterGroup = value as Filter;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Credit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    Radio(
                      value: Filter.CREDIT,
                      groupValue: widget.filterGroup,
                      onChanged: (value) => setState(
                        () {
                          widget.filterGroup = value as Filter;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Center(
                    child: Text(
                      "Apply",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                widget.handleFilter(widget.filterGroup);
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
