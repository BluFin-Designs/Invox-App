import 'package:flutter/material.dart';

class TransactionCategory {
  IconData icon;
  Color color;
  String title;

  TransactionCategory(
      {required this.title, required this.color, required this.icon});
}
