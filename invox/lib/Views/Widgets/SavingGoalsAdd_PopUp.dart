import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../Models/SavingGoalsModel.dart';
import '../../Repositories/SavingGoalsRepository.dart';

class SavingGoalsAddPopUp extends StatefulWidget {
  const SavingGoalsAddPopUp({Key? key}) : super(key: key);

  @override
  State<SavingGoalsAddPopUp> createState() => _SavingGoalsAddPopUpState();
}

class _SavingGoalsAddPopUpState extends State<SavingGoalsAddPopUp> {
  var uuid = Uuid();
  late String _newItemTitle;
  late double _newItemAmount;
  _addNewGoal(BuildContext context, SavingGoalsModel goal) {
    SavingGoalsRepository goalRepo = SavingGoalsRepository();
    try {
      goalRepo.addGoals(goal).then(
            (value) => Navigator.of(context).pop(true),
          );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to add new Goal!",
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: "Goal Title",
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  fillColor: Color(0xff8EA7E9),
                  filled: true,
                ),
                onChanged: (value) {
                  _newItemTitle = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Target Amount",
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  fillColor: Color(0xff8EA7E9),
                  filled: true,
                ),
                onChanged: (value) {
                  _newItemAmount = double.parse(
                    value.toString(),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF7286D3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  )),
              onPressed: () {
                if (_newItemAmount != 0.0 && _newItemTitle != null) {
                  _addNewGoal(
                      context,
                      SavingGoalsModel(
                          uid: uuid.v1(),
                          title: _newItemTitle,
                          txn: [],
                          requiredAmount: _newItemAmount));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please Enter the Valid Values!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 10,
                ),
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
