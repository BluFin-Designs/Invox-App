import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Models/Transaction_Model.dart';
import '../Models/CategoryModel.dart';
import '../Models/WalletModel.dart';
import '../utils/Transaction_Database.dart';

class TransactionRepository {
  Future<List<TransactionModel>> getTransactions() async {
    // var mainBox = await Hive.openBox('mainBox');
    return TransactionDatabase.transactions;
  }

  Future<TransactionModel> addTransaction(
    String uui,
    String title,
    String description,
    DateTime date,
    double amount,
    String txnType,
    Wallet wallet,
    TransactionCategory category,
    IconData icon,
  ) async {
    // var mainBox = await Hive.openBox('mainBox');
    // var transactions = await mainBox.get("transactions");
    // transactions != null ? transactions = transactions : transactions = [];
    TransactionModel tempTxn = TransactionModel(
      uid: uui,
      title: title,
      description: description,
      date: date,
      amount: amount,
      txnType: (txnType == "Credit")
          ? TransactionType.CREDIT
          : TransactionType.DEBIT,
      category: category,
      icons: icon,
    );

    TransactionDatabase.transactions.add(tempTxn);
    return tempTxn;

    // transactions.add(tempTxn);

    // await mainBox.put("transactions", transactions);
    // print(
    //   mainBox.get("transactions").toString(),
    // );
  }
}
