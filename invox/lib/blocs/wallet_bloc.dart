import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../Repositories/WalletRepository.dart';
import '../Models/WalletModel.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitialState()) {
    WalletRepository walletRepo = WalletRepository();
    List<Wallet> allWallets = [];

    on<WalletEvent>((event, emit) async {
      if (event is WalletLoadingEvent) {
        //Load-Data
        try {
          allWallets = await walletRepo.getWallets();
          emit(WalletLoadedState(allWallets));
        } catch (err) {
          emit(WalletLoadingErrorState());
        }
      } else if (event is WalletLoadedEvent) {
        emit(WalletLoadedState(allWallets));
      } else {
        emit(WalletLoadingErrorState());
      }
    });
  }
}
