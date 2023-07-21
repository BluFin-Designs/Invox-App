import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invox/Models/SavingGoalsModel.dart';
import '../../Models/GoalsTransactionModel.dart';
import '../../Repositories/GoalDetailsRepository.dart';
import '../Widgets/GoalAddPopUp.dart';
import '../Widgets/GoalEditPopUp.dart';
import '../../blocs/goalDetails_bloc.dart';
import '../Widgets/SavingGoalsCommonCard.dart';

class GoalDetailsPage extends StatefulWidget {
  static String routeName = '/budget_details';
  GoalDetailsPage({Key? key}) : super(key: key);

  @override
  State<GoalDetailsPage> createState() => _GoalDetailsPageState();
}

class _GoalDetailsPageState extends State<GoalDetailsPage> {
  double getSavingTotal(SavingGoalsModel goal) {
    double total = 0;
    for (int i = 0; i < goal.txn.length; i++) {
      total = total + goal.txn[i].amount;
    }
    return total;
  }

  var txninstance = GoalDetailsRepository();
  @override
  Widget build(BuildContext context) {
    SavingGoalsModel currentGoal =
        ModalRoute.of(context)?.settings.arguments as SavingGoalsModel;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        title: Text(currentGoal.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GoalsCard(
                    savingAmount: getSavingTotal(currentGoal),
                    requiredAmount: currentGoal.requiredAmount,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<GoalDetailsBloc, GoalDetailsState>(
                      builder: (context, state) {
                    if (state is GoalDetailsInitialState) {
                      BlocProvider.of<GoalDetailsBloc>(context)
                          .add(GoalDetailsLoadingEvent(currentGoal.uid));
                      return SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is GoalDetailsLoadedState) {
                      List<GoalsTransactionModel> allTxns =
                          state.goalDetails.txn;
                      if (allTxns.length != 0) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 350,
                          child: ListView.builder(
                            itemBuilder: (_, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Dismissible(
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      showDialog(
                                          context: _,
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
                                                      txninstance
                                                          .deleteGoalsTxn(
                                                              currentGoal.uid,
                                                              allTxns[index].uid
                                                                  as String)
                                                          .then((value) {
                                                        Navigator.pop(context);
                                                        BlocProvider.of<
                                                                    GoalDetailsBloc>(
                                                                context)
                                                            .add(
                                                                GoalDetailsLoadingEvent(
                                                                    currentGoal
                                                                        .uid));
                                                      });
                                                    });
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    } else {
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
                                            height: 260,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  GoalEditPopUp(
                                                      goalTxn: allTxns[index],
                                                      uid: currentGoal.uid)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ).then((value) => setState(() {
                                            BlocProvider.of<GoalDetailsBloc>(
                                                    context)
                                                .add(GoalDetailsLoadingEvent(
                                                    currentGoal.uid));
                                          }));
                                    }
                                  },
                                  background: slideRightBackground(),
                                  secondaryBackground: slideLeftBackground(),
                                  key: Key(allTxns[index].date.toString()),
                                  child: Container(
                                    height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF0F5FF),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            DateFormat('dd-MM-yyyy').format(
                                              allTxns[index].date.toLocal(),
                                            ),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            "+ ${allTxns[index].amount.toString()}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16,
                                              color: Colors.green,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: allTxns.length,
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 330,
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
                  }),
                ],
              ),
              InkWell(
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0xffC1C1C1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 26,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add New",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
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
                        height: 260,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
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
                              GoalAddPopUp(uid: currentGoal.uid),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
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
