import '../../utils/GoalsData.dart';
import 'package:flutter/material.dart';

class SavingGoalsAddPopUp extends StatefulWidget {
  const SavingGoalsAddPopUp({Key? key}) : super(key: key);

  @override
  State<SavingGoalsAddPopUp> createState() => _SavingGoalsAddPopUpState();
}

class _SavingGoalsAddPopUpState extends State<SavingGoalsAddPopUp> {
  String? _newItemTitle;
  double? _newItemAmount;
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
                  fillColor: Colors.grey,
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
                  fillColor: Colors.grey,
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
                  primary: const Color(0xFFFF7B54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  )),
              onPressed: () {
                if (_newItemAmount != 0.0 && _newItemTitle != null) {
                  Data.details.add({
                    "ItemName": _newItemTitle,
                    "RequiredAmount": _newItemAmount,
                  });
                  Navigator.of(context).pop();
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
