part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletInitialState extends WalletState {
  @override
  List<Object> get props => [];
}

class WalletLoadingErrorState extends WalletState {
  @override
  List<Object> get props => [];
}

class WalletLoadedState extends WalletState {
  List<Wallet> allWallets;

  WalletLoadedState(this.allWallets);

  @override
  List<Object> get props => [];
}
