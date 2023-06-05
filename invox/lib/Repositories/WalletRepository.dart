import '../utils/Wallets_Database.dart';
import '../Models/WalletModel.dart';

class WalletRepository {
  List<Wallet> getWallets() {
    return WalletsDatabase.wallets;
  }

  Future<bool> addWallets(Wallet wallet) async {
    try {
      WalletsDatabase.wallets.add(wallet);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteWallet(String uuid) async {
    try {
      WalletsDatabase.wallets.removeWhere((wallet) => wallet.Uid == uuid);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
