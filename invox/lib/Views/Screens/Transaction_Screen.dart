import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/Transaction_Model.dart';
import '../../Repositories/TransactionRepository.dart';
import '../../blocs/transactions_bloc.dart';
import '../Widgets/Add_Transaction.dart';
import '../Widgets/Edit_Transaction_PopUp.dart';
import '../Widgets/Summary_card.dart';
import '../Widgets/TransactionCard.dart';

class Transaction extends StatefulWidget {
  static const routeName = '/transaction';
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  var txninstance = TransactionRepository();
  @override
  void initState() {
    TransactionRepository().getTransactions();
    super.initState();
  }

  late List<TransactionModel> dailyTxn = [];
  late List<TransactionModel> monthlyTxn = [];
  late List<TransactionModel> yearlyTxn = [];
  double dailyDebit = 0;
  double dailyCredit = 0;
  double monthlyDebit = 0;
  double monthlyCredit = 0;
  double yearlyDebit = 0;
  double yearlyCredit = 0;

  void txnDivision(List<TransactionModel> allTxns) {
    DateTime today = DateTime.now();
    DateTime todate = DateTime(today.year, today.month, today.day);
    for (var transaction in allTxns) {
      DateTime currentDate = transaction.date as DateTime;
      if (todate.isAtSameMomentAs(
          DateTime(currentDate.year, currentDate.month, currentDate.day))) {
        dailyTxn.add(transaction);
        if (transaction.txnType == TransactionType.DEBIT) {
          dailyDebit = dailyDebit + transaction.amount!;
        } else if (transaction.txnType == TransactionType.CREDIT) {
          dailyCredit = dailyCredit + transaction.amount!;
        }
      }
      if (currentDate.month == today.month && currentDate.year == today.year) {
        monthlyTxn.add(transaction);
        if (transaction.txnType == TransactionType.DEBIT) {
          monthlyDebit = monthlyDebit + transaction.amount!;
        } else if (transaction.txnType == TransactionType.CREDIT) {
          monthlyCredit = monthlyCredit + transaction.amount!;
        }
      }
      if (currentDate.year == today.year) {
        yearlyTxn.add(transaction);
        if (transaction.txnType == TransactionType.DEBIT) {
          yearlyDebit = yearlyDebit + transaction.amount!;
        } else if (transaction.txnType == TransactionType.CREDIT) {
          yearlyCredit = yearlyCredit + transaction.amount!;
        }
      }
    }
  }

  final _txnKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("My Transactions"),
          centerTitle: false,
        ),
        body: BlocBuilder<TransactionsBloc, TransactionsState>(
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
            txnDivision(state.allTransactions);
            return Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 43.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8EA7E9),
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    child: SizedBox(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: TabBar(
                        indicatorPadding: const EdgeInsets.all(7.0),
                        indicator: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        tabs: const [
                          Text(
                            "Daily",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            "Monthly",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            "Yearly",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 190,
                      child: TabBarView(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 100,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: SummaryCard(
                                      credit: dailyCredit, debit: dailyDebit),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  child: AddTransaction(),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                (dailyTxn.isNotEmpty)
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (ctx, index) {
                                          return Dismissible(
                                              confirmDismiss:
                                                  (direction) async {
                                                if (direction ==
                                                    DismissDirection
                                                        .endToStart) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          content: const Text(
                                                              "Are you sure you want to delete ?"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: const Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false);
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                              onPressed: () {
                                                                // TODO: Delete the item from DB etc..
                                                                setState(() {
                                                                  txninstance
                                                                      .deleteTransaction(
                                                                          dailyTxn[index].uid
                                                                              as String)
                                                                      .then(
                                                                          (value) {
                                                                    Navigator.pop(
                                                                        context);
                                                                    BlocProvider.of<TransactionsBloc>(
                                                                            context)
                                                                        .add(
                                                                            TransactionLoadingEvent());
                                                                  });
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                } else {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    useSafeArea: true,
                                                    context: context,
                                                    builder: (context) =>
                                                        Dialog(
                                                      insetPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 20,
                                                              horizontal: 10),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            40,
                                                        height: 600,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: <Widget>[
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                "Edit Transaction",
                                                                style:
                                                                    TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              EditTransactionPopUp(
                                                                  txn: dailyTxn[
                                                                      index]),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ).then(
                                                      (value) => setState(() {
                                                            BlocProvider.of<
                                                                        TransactionsBloc>(
                                                                    context)
                                                                .add(
                                                                    TransactionLoadingEvent());
                                                          }));
                                                }
                                              },
                                              background:
                                                  slideRightBackground(),
                                              secondaryBackground:
                                                  slideLeftBackground(),
                                              key: Key(dailyTxn[index].title),
                                              child: TransactionCard(
                                                  txn: dailyTxn[index]));
                                        },
                                        itemCount: dailyTxn.length,
                                      )
                                    : SizedBox(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Center(
                                          child: Text(
                                              "Oops, No Transactions yet!"),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 100,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: SummaryCard(
                                      credit: monthlyCredit,
                                      debit: monthlyDebit),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  child: AddTransaction(),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                (monthlyTxn.isNotEmpty)
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (ctx, index) {
                                          return Dismissible(
                                              confirmDismiss:
                                                  (direction) async {
                                                if (direction ==
                                                    DismissDirection
                                                        .endToStart) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          content: const Text(
                                                              "Are you sure you want to delete ?"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: const Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false);
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                              onPressed: () {
                                                                // TODO: Delete the item from DB etc..
                                                                setState(() {
                                                                  txninstance
                                                                      .deleteTransaction(
                                                                          monthlyTxn[index].uid
                                                                              as String)
                                                                      .then(
                                                                          (value) {
                                                                    Navigator.pop(
                                                                        context);
                                                                    BlocProvider.of<TransactionsBloc>(
                                                                            context)
                                                                        .add(
                                                                            TransactionLoadingEvent());
                                                                  });
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                } else {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    useSafeArea: true,
                                                    context: context,
                                                    builder: (context) =>
                                                        Dialog(
                                                      insetPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 20,
                                                              horizontal: 10),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            40,
                                                        height: 600,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: <Widget>[
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                "Edit Transaction",
                                                                style:
                                                                    TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              EditTransactionPopUp(
                                                                  txn: monthlyTxn[
                                                                      index]),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ).then(
                                                      (value) => setState(() {
                                                            BlocProvider.of<
                                                                        TransactionsBloc>(
                                                                    context)
                                                                .add(
                                                                    TransactionLoadingEvent());
                                                          }));
                                                }
                                              },
                                              background:
                                                  slideRightBackground(),
                                              secondaryBackground:
                                                  slideLeftBackground(),
                                              key: Key(monthlyTxn[index].title),
                                              child: TransactionCard(
                                                  txn: monthlyTxn[index]));
                                        },
                                        itemCount: monthlyTxn.length,
                                      )
                                    : SizedBox(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Center(
                                          child: Text(
                                              "Oops, No Transactions yet!"),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 100,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: SummaryCard(
                                      credit: yearlyCredit, debit: yearlyDebit),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  child: AddTransaction(),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                (yearlyTxn.isNotEmpty)
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (ctx, index) {
                                          return Dismissible(
                                              confirmDismiss:
                                                  (direction) async {
                                                if (direction ==
                                                    DismissDirection
                                                        .endToStart) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          content: const Text(
                                                              "Are you sure you want to delete ?"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: const Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false);
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                              onPressed: () {
                                                                // TODO: Delete the item from DB etc..
                                                                setState(() {
                                                                  txninstance
                                                                      .deleteTransaction(
                                                                          yearlyTxn[index].uid
                                                                              as String)
                                                                      .then(
                                                                          (value) {
                                                                    Navigator.pop(
                                                                        context);
                                                                    BlocProvider.of<TransactionsBloc>(
                                                                            context)
                                                                        .add(
                                                                            TransactionLoadingEvent());
                                                                  });
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                } else {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    useSafeArea: true,
                                                    context: context,
                                                    builder: (context) =>
                                                        Dialog(
                                                      insetPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 20,
                                                              horizontal: 10),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            40,
                                                        height: 600,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: <Widget>[
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                "Edit Transaction",
                                                                style:
                                                                    TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              EditTransactionPopUp(
                                                                  txn: yearlyTxn[
                                                                      index]),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ).then(
                                                      (value) => setState(() {
                                                            BlocProvider.of<
                                                                        TransactionsBloc>(
                                                                    context)
                                                                .add(
                                                                    TransactionLoadingEvent());
                                                          }));
                                                }
                                              },
                                              background:
                                                  slideRightBackground(),
                                              secondaryBackground:
                                                  slideLeftBackground(),
                                              key: Key(yearlyTxn[index].title),
                                              child: TransactionCard(
                                                  txn: yearlyTxn[index]));
                                        },
                                        itemCount: yearlyTxn.length,
                                      )
                                    : SizedBox(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Center(
                                          child: Text(
                                              "Oops, No Transactions yet!"),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
        }),
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
