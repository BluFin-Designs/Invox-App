import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../Models/GoalsTransactionModel.dart';
import '../../Repositories/GoalDetailsRepository.dart';

class GoalAddPopUp extends StatefulWidget {
  final String uid;
  const GoalAddPopUp({Key? key, required this.uid}) : super(key: key);

  @override
  State<GoalAddPopUp> createState() => _GoalAddPopUpState();
}

class _GoalAddPopUpState extends State<GoalAddPopUp> {
  var uuid = Uuid();
  DateTime _selectedDate = DateTime.now();
  late double _newAmount;

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
              height: 5,
            ),
            SizedBox(
              width: 320,
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 320,
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
                if (_newAmount != 0.0) {
                  GoalDetailsRepository()
                      .addGoalDetails(
                          GoalsTransactionModel(
                            uid: uuid.v1(),
                            date: _selectedDate,
                            amount: _newAmount,
                          ),
                          widget.uid)
                      .then(
                        (value) => Navigator.pop(context),
                      );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please Enter the Valid Values!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 10,
                ),
                child: Text(
                  "Add",
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
