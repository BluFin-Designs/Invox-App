import 'package:flutter/material.dart';
import '../Widgets/SavingGoals_Card.dart';
import '../Widgets/SavingGoalsAdd_PopUp.dart';
import '../Widgets/SavingGoalsCommonCard.dart';
import '../../utils/GoalsData.dart';

class SavingGoals extends StatefulWidget {
  static const routeName = '/savingGoals';
  const SavingGoals({Key? key}) : super(key: key);

  @override
  State<SavingGoals> createState() => _SavingGoalsState();
}

class _SavingGoalsState extends State<SavingGoals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Saving Goals"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GoalsCard(),
              const SizedBox(
                height: 10.0,
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (ctx, index) {
                  if (index < Data.details.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5.0),
                      child: SavingGoalsCard(
                          value_1: Data.details[index]["SavingsAmount"],
                          value_2: Data.details[index]["RequiredAmount"],
                          itemName: Data.details[index]["ItemName"]),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5.0),
                      child: InkWell(
                        child: Container(
                          height: 180,
                          width: 172,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC1C1C1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F0F0),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                )),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
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
                                          color: Color(0xFFFF7B54),
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
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
                itemCount: Data.details.length + 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
