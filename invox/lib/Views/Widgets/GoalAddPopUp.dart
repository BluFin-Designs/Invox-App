import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/GoalData.dart';

class GoalAddPopUp extends StatefulWidget {
  final GoalFunction goalFunction;
  final int goalIndex;
  final int? transactionIndex;
  final double? initialValue;
  final DateTime? initialDate;

  const GoalAddPopUp({
    required this.goalIndex,
    required this.goalFunction,
    this.initialDate,
    this.initialValue,
    this.transactionIndex,
    Key? key,
  }) : super(key: key);

  @override
  State<GoalAddPopUp> createState() => _GoalAddPopUpState();
}

class _GoalAddPopUpState extends State<GoalAddPopUp> {
  DateTime? _selectedDate;
  double? _newAmount;

  @override
  void initState() {
    _selectedDate = widget.initialDate;
    _newAmount = widget.initialValue;
    super.initState();
  }

  void _updateTransaction(double amount, DateTime date) {
    Goals.goals[widget.goalIndex]["transactions"][widget.transactionIndex] = {
      "date": date,
      "amount": amount,
    };
  }

  void _addNewTransaction(double amount, DateTime date) {
    Goals.goals[widget.goalIndex]["transactions"].add({
      "date": date,
      "amount": amount,
    });
  }

  Future<void> _selectDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
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
                initialValue:
                    _newAmount != null ? _newAmount.toString() : "Amount",
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
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
                  fillColor: Colors.grey,
                  filled: true,
                ),
                onChanged: (value) {
                  _newAmount = double.parse(value);
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
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            _selectedDate != null
                                ? DateFormat('dd-MM-yyyy')
                                    .format(_selectedDate!)
                                : "DD-MM-YYYY"
                                    .split(' ')[0]
                                    .replaceAll("-", "/"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
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
                  primary: const Color(0xFFFF7B54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  )),
              onPressed: () {
                if (widget.goalFunction == GoalFunction.update) {
                  _updateTransaction(_newAmount!, _selectedDate!);
                  Navigator.pop(context);
                } else {
                  _addNewTransaction(_newAmount!, _selectedDate!);
                  Navigator.pop(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 10,
                ),
                child: Text(
                  (widget.goalFunction == GoalFunction.create)
                      ? "Add"
                      : "Update",
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
