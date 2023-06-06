import 'package:flutter/material.dart';

class Wallet {
  String Uid;
  String title;
  double amount;
  Color color;

  Wallet(
      {this.amount = 0,
      required this.title,
      required this.Uid,
      required this.color});
}
