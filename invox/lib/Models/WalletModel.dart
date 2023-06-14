import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'WalletModel.g.dart';

@HiveType(typeId: 0)
class Wallet {
  @HiveField(0)
  String Uid;

  @HiveField(1)
  String title;

  @HiveField(2)
  double amount;

  @HiveField(3)
  int color;

  Wallet(
      {this.amount = 0,
      required this.title,
      required this.Uid,
      required this.color});
}
