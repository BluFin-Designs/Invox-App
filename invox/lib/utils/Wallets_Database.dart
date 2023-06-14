import 'package:flutter/material.dart';
import '../Models/WalletModel.dart';

class WalletsDatabase {
  static List<Wallet> wallets = [
    Wallet(
        amount: 5000,
        title: 'Cash',
        Uid: "4cc8082e-07ae-11ee-be56-0242ac120002",
        color: 0xff8EA7E9),
    Wallet(
        amount: 500,
        title: 'Digital Wallet',
        Uid: "4cc80de2-07ae-11ee-be56-0242ac120002",
        color: 0xff91D8E4),
    Wallet(
        amount: 1000,
        title: 'Others',
        Uid: "4cc810a8-07ae-11ee-be56-0242ac120002",
        color: 0xff7286D3),
  ];
}
