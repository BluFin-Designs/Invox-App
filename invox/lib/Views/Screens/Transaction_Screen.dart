import 'package:flutter/material.dart';
import '../Widgets/Add_Transaction.dart';
import '../Widgets/Summary_card.dart';
import '../Widgets/TransactionCard.dart';

class Transaction extends StatefulWidget {
  static const routeName = '/transaction';
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
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
        body: Padding(
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
                child: TabBar(
                  indicatorPadding: const EdgeInsets.all(7.0),
                  indicator: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  tabs: [
                    const Text(
                      "Daily",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    const Text(
                      "Monthly",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    const Text(
                      "Yearly",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: SummaryCard(credit: 1956, debit: 134),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: AddTransaction(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              return TransactionCard();
                            },
                            itemCount: 5,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: SummaryCard(credit: 11956, debit: 834),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: AddTransaction(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              return TransactionCard();
                            },
                            itemCount: 7,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: SummaryCard(credit: 111956, debit: 5734),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: AddTransaction(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              return TransactionCard();
                            },
                            itemCount: 9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
