import 'package:flutter/material.dart';

class TransactionCategoryModel {
  String Uid;
  IconData icon;
  Color color;
  String title;

  TransactionCategoryModel(
      {required this.title,
      required this.color,
      required this.icon,
      required this.Uid});
}
