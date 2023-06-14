import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import './CategoryModel.dart';

part 'Transaction_Model.g.dart';

@HiveType(typeId: 3)
enum TransactionType {
  @HiveField(0)
  CREDIT,

  @HiveField(1)
  DEBIT,
}

@HiveType(typeId: 1)
class TransactionModel {
  @HiveField(0)
  String? uid;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  double? amount;

  @HiveField(4)
  int icons;

  @HiveField(5)
  DateTime? date;

  @HiveField(6)
  TransactionCategoryModel? category;

  @HiveField(7)
  TransactionType? txnType;

  TransactionModel({
    this.uid,
    this.title,
    this.description,
    this.amount,
    required this.icons,
    this.date,
    this.category,
    this.txnType,
  });
}
