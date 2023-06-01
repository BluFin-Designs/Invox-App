import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../Repositories/TransactionRepository.dart';
import '../Models/Transaction_Model.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsInitialState()) {
    TransactionRepository txnRepo = TransactionRepository();
    List<TransactionModel> allTxns = [];

    on<TransactionsEvent>((event, emit) async {
      if (event is TransactionLoadingEvent) {
        //Load-Data
        try {
          allTxns = await txnRepo.getTransactions();
          emit(TransactionsLoadedState(allTxns));
        } catch (err) {
          emit(TransactionsLoadingErrorState());
        }
      } else if (event is TransactionLoadedEvent) {
        emit(TransactionsLoadedState(allTxns));
      } else {
        emit(TransactionsLoadingErrorState());
      }
    });
  }
}
