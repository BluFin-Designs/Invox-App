import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Models/Transaction_Model.dart';
import '../Models/CategoryModel.dart';
import '../Models/WalletModel.dart';
import '../utils/Transaction_Database.dart';

class TransactionRepository {
  var mainBox = Hive.box("database");

  Future<List<TransactionModel>> getTransactions() async {
    List<TransactionModel> allTransactions =
        mainBox.get("transactions")?.cast<TransactionModel>() ?? [];
    return allTransactions;
    // var mainBox = await Hive.openBox('mainBox');
    // return TransactionDatabase.transactions;
  }

  static Future<bool> deleteTransaction(String uui) async {
    TransactionDatabase.transactions
        .removeWhere((transactions) => transactions.uid == uui);
    return true;
  }

  Future<TransactionModel> editTransaction(
    String uui,
    String title,
    String description,
    DateTime date,
    double amount,
    String txnType,
    Wallet wallet,
    TransactionCategoryModel category,
    int icon,
  ) async {
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
    final index = TransactionDatabase.transactions
        .indexWhere((element) => element.uid == tempTxn.uid);
    TransactionDatabase.transactions[index] = tempTxn;
    return tempTxn;
  }

  Future<bool> addTransaction(
    String uui,
    String title,
    String description,
    DateTime date,
    double amount,
    String txnType,
    Wallet wallet,
    TransactionCategoryModel category,
    int icon,
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

    try {
      // WalletsDatabase.wallets.add(wallet);
      List<TransactionModel> allTransactions =
          mainBox.get("transactions")?.cast<TransactionModel>() ?? [];
      allTransactions.add(tempTxn);
      mainBox.put("transactions", allTransactions);
      return true;
    } catch (e) {
      throw Exception(e);
    }

    // transactions.add(tempTxn);

    // await mainBox.put("transactions", transactions);
    // print(
    //   mainBox.get("transactions").toString(),
    // );
  }
}
