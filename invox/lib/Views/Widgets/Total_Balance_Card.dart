import 'package:flutter/material.dart';

class Total_Balance_Card extends StatelessWidget {
  final double amount;
  const Total_Balance_Card({
    Key? key,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFFF0F0F0),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFC1C1C1),
            blurRadius: 4,
            offset: Offset(4, 4), // Shadow position
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                "Amount",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 24.0,
          ),
          Text(
            "₹ $amount",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 32.0),
          ),
        ],
      ),
    );
  }
}
