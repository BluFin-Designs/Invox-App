import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Widgets/GoalAddPopUp.dart';
import '../../utils/GoalData.dart';

class BudgetDetailsPage extends StatefulWidget {
  static String routeName = '/budget_details';
  const BudgetDetailsPage({Key? key}) : super(key: key);

  @override
  State<BudgetDetailsPage> createState() => _BudgetDetailsPageState();
}

class _BudgetDetailsPageState extends State<BudgetDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "iPhone 14",
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 370,
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      Map _goal = Goals.goals[0]["transactions"][index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Dismissible(
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              final bool res = await showDialog(
                                  context: _,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: const Text(
                                          "Are you sure you want to delete ?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: const Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                        ),
                                        FlatButton(
                                          child: const Text(
                                            "Delete",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () {
                                            // TODO: Delete the item from DB etc..
                                            setState(() {
                                              Goals.goals[0]["transactions"]
                                                  .removeAt(index);
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              return res;
                            } else {
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
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    height: 260,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            "Your Today’s Saving",
                                            style: TextStyle(
                                              color: Color(0xFFFF7B54),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          GoalAddPopUp(
                                            goalIndex: 0,
                                            goalFunction: GoalFunction.update,
                                            transactionIndex: index,
                                            initialValue: _goal["amount"],
                                            initialDate: _goal["date"],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          background: slideRightBackground(),
                          secondaryBackground: slideLeftBackground(),
                          key: Key(_goal["date"].toString()),
                          child: Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: const Color(0xffF0F0F0),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('dd-MM-yyyy').format(
                                      _goal["date"].toLocal(),
                                    ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "+ ${_goal["amount"].toString()}",
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
                    itemCount: Goals.goals[0]["transactions"].length,
                  ),
                ),
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
                          children: const <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Your Today’s Saving",
                              style: TextStyle(
                                color: Color(0xFFFF7B54),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            GoalAddPopUp(
                              goalIndex: 0,
                              goalFunction: GoalFunction.create,
                            ),
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
