import 'package:flutter/material.dart';

import '../../utils/BudgetData.dart';

class ModifyBudgetPopUp extends StatefulWidget {
  final Budget budgetId;
  const ModifyBudgetPopUp({required this.budgetId, Key? key}) : super(key: key);

  @override
  State<ModifyBudgetPopUp> createState() => _ModifyBudgetPopUpState();
}

class _ModifyBudgetPopUpState extends State<ModifyBudgetPopUp> {
  double? _newAmount;

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
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  prefixText: "₹ ",
                  hintText: "Amount",
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
                  _newAmount = double.parse(
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
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  )),
              onPressed: () {
                BudgetData.modifyData(widget.budgetId, _newAmount!);
                Navigator.pop(context);
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
