import '../utils/Wallets_Database.dart';
import '../Models/WalletModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WalletRepository {
  var mainBox = Hive.box("database");

  WalletRepository() {
    List<Wallet> allWallets = mainBox.get("wallets")?.cast<Wallet>() ?? [];
    if (allWallets.isEmpty) {
      mainBox.put("wallets", WalletsDatabase.wallets);
      print("Added default wallets!");
    }
  }

  List<dynamic> getWallets() {
    List<Wallet> allWallets = mainBox.get("wallets")?.cast<Wallet>();
    return allWallets;
  }

  Future<bool> addWallets(Wallet wallet) async {
    try {
      // WalletsDatabase.wallets.add(wallet);
      List<Wallet> allWallets = mainBox.get("wallets")?.cast<Wallet>();
      allWallets.add(wallet);
      mainBox.put("wallets", allWallets);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteWallet(String uuid) async {
    try {
      List<Wallet> allWallets = mainBox.get("wallets")?.cast<Wallet>();
      allWallets.removeWhere((wallet) => wallet.Uid == uuid);
      mainBox.put("wallets", allWallets);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
