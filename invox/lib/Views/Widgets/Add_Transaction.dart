import 'package:flutter/material.dart';

import '../Widgets/Add_Transaction_PopUp.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          "Add Transaction",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      onTap: () {
        showDialog(
          barrierDismissible: false,
          useSafeArea: true,
          context: context,
          builder: (_) => Dialog(
            insetPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 530,
              child: SingleChildScrollView(
                child: Column(
                  children: const <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "New Transaction",
                      style: TextStyle(
                        color: Color(0xFFFF7B54),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    AddTransactionPopUp(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
