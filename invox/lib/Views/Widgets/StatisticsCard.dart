import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard(
      {super.key,
      required this.text,
      required this.amount,
      required this.icon,
      required this.color});
  final String text;
  final double? amount;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: 70,
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
                    color: color, borderRadius: BorderRadius.circular(5)),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 25.0,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "₹ ${amount?.toStringAsFixed(0)}",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
