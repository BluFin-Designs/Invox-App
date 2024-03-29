import 'package:hive_flutter/hive_flutter.dart';

import '../Models/CategoryModel.dart';
import '../Models/Transaction_Model.dart';
import '../Models/WalletModel.dart';

class TransactionRepository {
  var mainBox = Hive.box("database");

  Future<List<TransactionModel>> getTransactions() async {
    List<TransactionModel> allTransactions =
        mainBox.get("transactions")?.cast<TransactionModel>() ?? [];
    allTransactions.sort((a, b) => b.date!.compareTo(a.date as DateTime));
    // print(allTransactions);
    return allTransactions;
    // var mainBox = await Hive.openBox('mainBox');
    // return TransactionDatabase.transactions;
  }

  Future<bool> deleteTransaction(String uui) async {
    double? tempAmt = 0;
    Wallet? wallett;
    TransactionType? type;
    /*TransactionDatabase.transactions
        .removeWhere((transactions) => transactions.uid == uui);*/
    try {
      List<TransactionModel> allTransactions =
          mainBox.get("transactions")?.cast<TransactionModel>() ?? [];
      allTransactions.removeWhere((transactions) {
        if (transactions.uid == uui) {
          tempAmt = transactions.amount;
          wallett = transactions.wallet;
          type = transactions.txnType;
          return true;
        } else {
          return false;
        }
      });
      mainBox.put("transactions", allTransactions);
      List<Wallet> allWallets = mainBox.get("wallets")?.cast<Wallet>();
      for (var wallet in allWallets) {
        if (wallet == wallett) {
          if (type == TransactionType.CREDIT) {
            wallet.amount = wallet.amount - tempAmt!;
          } else if (type == TransactionType.DEBIT) {
            wallet.amount = wallet.amount + tempAmt!;
          }
        }
      }
      mainBox.put("wallets", allWallets);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> editTransaction(
    String uui,
    String title,
    String description,
    DateTime date,
    double amount,
    String txnType,
    Wallet wallet,
    TransactionCategoryModel category,
    int icon,
    double prevAmt,
  ) async {
    TransactionModel tempTxn = TransactionModel(
      uid: uui,
      title: title,
      description: description,
      date: date,
      amount: amount,
      wallet: wallet,
      txnType: (txnType == "Credit")
          ? TransactionType.CREDIT
          : TransactionType.DEBIT,
      category: category,
      icons: icon,
    );
    /*final index = TransactionDatabase.transactions
        .indexWhere((element) => element.uid == tempTxn.uid);
    TransactionDatabase.transactions[index] = tempTxn;
    return tempTxn;*/
    try {
      // WalletsDatabase.wallets.add(wallet);
      List<TransactionModel> allTransactions =
          mainBox.get("transactions")?.cast<TransactionModel>() ?? [];
      final index =
          allTransactions.indexWhere((element) => element.uid == tempTxn.uid);
      allTransactions[index] = tempTxn;
      //print(allTransactions);
      mainBox.put("transactions", allTransactions);
      List<Wallet> allWallets = mainBox.get("wallets")?.cast<Wallet>();
      for (var wallet in allWallets) {
        if (tempTxn.wallet == wallet) {
          if (tempTxn.amount! - prevAmt < 0) {
            wallet.amount = wallet.amount + (prevAmt - tempTxn.amount!);
          } else if (tempTxn.amount! - prevAmt > 0) {
            wallet.amount = wallet.amount - (tempTxn.amount! - prevAmt);
          }
        }
      }
      mainBox.put("wallets", allWallets);
      return true;
    } catch (e) {
      throw Exception(e);
    }
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
      wallet: wallet,
      category: category,
      icons: icon,
    );

    try {
      // WalletsDatabase.wallets.add(wallet);
      List<TransactionModel> allTransactions =
          mainBox.get("transactions")?.cast<TransactionModel>() ?? [];
      allTransactions.add(tempTxn);
      mainBox.put("transactions", allTransactions);
      List<Wallet> allWallets = mainBox.get("wallets")?.cast<Wallet>();
      for (var wallet in allWallets) {
        if (tempTxn.wallet == wallet) {
          if (tempTxn.txnType == TransactionType.CREDIT) {
            wallet.amount = wallet.amount + tempTxn.amount!;
          } else if (tempTxn.txnType == TransactionType.DEBIT) {
            wallet.amount = wallet.amount - tempTxn.amount!;
          }
        }
      }
      mainBox.put("wallets", allWallets);
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
