import 'package:flutter/material.dart';
import '../Models/WalletModel.dart';

class WalletsDatabase {
  static List<Wallet> wallets = [
    Wallet(amount: 5000, title: 'Cash', Uid: "45"),
    Wallet(amount: 500, title: 'Digital Wallet', Uid: "89"),
    Wallet(amount: 1000, title: 'Others', Uid: "34"),
  ];
}