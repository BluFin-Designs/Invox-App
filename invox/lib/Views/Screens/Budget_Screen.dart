import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invox/blocs/cubits/budget_cubit.dart';

import '../../Repositories/BudgetRepository.dart';
import '../Widgets/ModifyBudget_PupUp.dart';

class BudgetPage extends StatefulWidget {
  static String routeName = '/budget';
  const BudgetPage({Key? key}) : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  _refreshPage() {
    setState(() {
      BlocProvider.of<BudgetCubit>(context).updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Called!");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<BudgetCubit, BudgetState>(
        builder: (context, state) {
          if (state is BudgetLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BudgetLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  BudgetCard(
                    title: "Monthly",
                    value: state.monthly,
                    color: Theme.of(context).primaryColor,
                    id: budgetType.MONTH,
                    updateHandle: _refreshPage,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BudgetCard(
                    title: "Weekly",
                    value: state.weekly,
                    color: Theme.of(context).colorScheme.secondary,
                    id: budgetType.WEEK,
                    updateHandle: _refreshPage,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text("Error Loading Data :("),
            );
          }
        },
      ),
    );
  }
}

class BudgetCard extends StatelessWidget {
  String title;
  double value;
  Color color;
  VoidCallback updateHandle;
  budgetType id;

  BudgetCard({
    required this.updateHandle,
    required this.color,
    required this.title,
    required this.value,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xffF0F5FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "₹ $value",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 16),
                )
              ],
            ),
            IconButton(
              onPressed: () {
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
                      height: 200,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "New Category",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            ModifyBudgetPopUp(budgetId: id),
                          ],
                        ),
                      ),
                    ),
                  ),
                ).then((value) => updateHandle());
              },
              icon: const Icon(
                Icons.edit,
                color: Color(0xff0A2647),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
