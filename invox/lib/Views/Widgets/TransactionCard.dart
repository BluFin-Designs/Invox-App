import 'dart:convert';

import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final double? amount;
  const TransactionCard({this.amount, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double? _amt = (amount != null) ? amount : 0.00;
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
                child: const Icon(
                  Icons.shopping_basket,
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
                  children: const [
                    Text(
                      "Groceries",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Apple, Milk, Dry Fruits",
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
                (_amt! > 0)
                    ? "+ ₹${_amt.toStringAsFixed(2)}"
                    : "- ₹${(_amt.abs()).toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: (_amt > 0) ? Colors.green : Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
