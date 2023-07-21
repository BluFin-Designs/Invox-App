import 'package:flutter/material.dart';

import '../../Models/GoalsTransactionModel.dart';
import '../../Repositories/GoalDetailsRepository.dart';

class GoalEditPopUp extends StatefulWidget {
  final GoalsTransactionModel goalTxn;
  final String uid;
  const GoalEditPopUp({
    Key? key,required this.goalTxn,required this.uid
  }) : super(key: key);

  @override
  State<GoalEditPopUp> createState() => _GoalEditPopUpState();
}

class _GoalEditPopUpState extends State<GoalEditPopUp> {
  String uuid = "";
  DateTime _selectedDate = DateTime.now();
  double _amount = 0;
  Future<void> _selectDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
      context: ctx,
      initialDate: _selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    _amount = widget.goalTxn.amount;
    uuid = widget.goalTxn.uid;
    _selectedDate = widget.goalTxn.date!;
    super.initState();
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: _amount.toString(),
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
                  _amount = double.parse(
                    value.toString(),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 330,
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 330,
                    decoration: BoxDecoration(
                      color: Color(0xff8EA7E9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "${_selectedDate.toLocal()}"
                                .split(' ')[0]
                                .replaceAll("-", "/"),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _selectDate(context),
                          icon: const Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
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
                GoalDetailsRepository().editGoalsTransaction(GoalsTransactionModel(
                  uid: uuid, date: _selectedDate, amount: _amount,), widget.uid).then(
                      (value) => Navigator.pop(context),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 10,
                ),
                child: Text(
                  "Edit",
                  style: const TextStyle(
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
