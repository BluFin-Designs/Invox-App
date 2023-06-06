part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
}

class WalletLoadingEvent extends WalletEvent {
  @override
  List<Object> get props => [];
}

class WalletLoadingErrorEvent extends WalletEvent {
  @override
  List<Object> get props => [];
}

class WalletLoadedEvent extends WalletEvent {
  @override
  List<Object> get props => [];
}
