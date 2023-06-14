import 'package:flutter/material.dart';

import '../../Models/Transaction_Model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel txn;
  TransactionCard({required this.txn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double? _amt = (txn.amount != null) ? txn.amount : 0.00;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 5.0,
      ),
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: const Color(0xffF0F5FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(
                  IconData(txn.icons, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      txn.title.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      txn.description.toString(),
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xff0A2647),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                (txn.txnType == TransactionType.CREDIT)
                    ? "+ ₹${_amt?.toStringAsFixed(2)}"
                    : "- ₹${(_amt?.abs())?.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: (txn.txnType == TransactionType.CREDIT)
                      ? Colors.green
                      : Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
