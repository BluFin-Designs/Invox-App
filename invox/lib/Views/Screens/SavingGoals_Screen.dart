import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './GoalDetails_Screen.dart';
import '../Widgets/SavingGoals_Card.dart';
import '../Widgets/SavingGoalsAdd_PopUp.dart';
import '../Widgets/SavingGoalsCommonCard.dart';
import '../../Models/SavingGoalsModel.dart';
import '../../blocs/goals_bloc.dart';

class SavingGoals extends StatefulWidget {
  static const routeName = '/savingGoals';
  const SavingGoals({Key? key}) : super(key: key);

  @override
  State<SavingGoals> createState() => _SavingGoalsState();
}

class _SavingGoalsState extends State<SavingGoals> {
  void refreshPage() {
    setState(() {
      BlocProvider.of<GoalsBloc>(context).add(GoalLoadingEvent());
    });
  }

  double getSavingTotal(List<SavingGoalsModel> allGoals) {
    double total = 0;
    for (int i = 0; i < allGoals.length; i++) {
      for (int j = 0; j < allGoals[i].txn.length; j++) {
        total = total + allGoals[i].txn[j].amount;
      }
    }
    return total;
  }

  double getRequiredTotal(List<SavingGoalsModel> allGoals) {
    double total = 0;
    for (int i = 0; i < allGoals.length; i++) {
      total = total + allGoals[i].requiredAmount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Saving Goals"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<GoalsBloc, GoalsState>(
        builder: (context, state) {
          if (state is GoalsInitialState) {
            BlocProvider.of<GoalsBloc>(context).add(GoalLoadingEvent());
            return SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is GoalsLoadedState) {
            List<SavingGoalsModel> allGoals = state.allGoals;
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GoalsCard(
                      savingAmount: getSavingTotal(allGoals),
                      requiredAmount: getRequiredTotal(allGoals),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: .9,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (ctx, index) {
                        if (index < allGoals.length) {
                          return InkWell(
                            child: SavingGoalsCard(
                              goal: allGoals[index],
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                      context, GoalDetailsPage.routeName,
                                      arguments: allGoals[index])
                                  .then((value) => refreshPage());
                            },
                          );
                        } else {
                          return InkWell(
                            child: Container(
                              height: 190,
                              width: 172,
                              decoration: BoxDecoration(
                                color: const Color(0xFF8EA7E9),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xffF0F5FF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                    )),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  // barrierDismissible: false,
                                  useSafeArea: true,
                                  context: context,
                                  builder: (_) => Dialog(
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
                                          height: 280,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: const <Widget>[
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Your New Goal",
                                                  style: TextStyle(
                                                    color: Color(0xFF7286D3),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SavingGoalsAddPopUp(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )).then(
                                (value) => refreshPage(),
                              );
                            },
                          );
                        }
                      },
                      itemCount: allGoals.length + 1,
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
                child: Text("Error Loading Data!"),
              ),
            );
          }
        },
      ),
    );
  }
}
