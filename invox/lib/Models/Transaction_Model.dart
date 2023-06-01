import 'package:flutter/material.dart';
import './CategoryModel.dart';

enum TransactionType { CREDIT, DEBIT }

class TransactionModel {
  String? uid;
  String? title;
  String? description;
  double? amount;
  IconData? icons;
  DateTime? date;
  TransactionCategory? category;
  TransactionType? txnType;

  TransactionModel({
    this.uid,
    this.title,
    this.description,
    this.amount,
    this.icons,
    this.date,
    this.category,
    this.txnType,
  });
}
