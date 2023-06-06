import 'package:flutter/material.dart';
import '../Models/WalletModel.dart';

class WalletsDatabase {
  static List<Wallet> wallets = [
    Wallet(amount: 5000, title: 'Cash', Uid: "45", color: Color(0xff8EA7E9)),
    Wallet(
        amount: 500,
        title: 'Digital Wallet',
        Uid: "89",
        color: Color(0xff91D8E4)),
    Wallet(amount: 1000, title: 'Others', Uid: "34", color: Color(0xff7286D3)),
  ];
}
