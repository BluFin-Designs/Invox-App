part of 'transactions_bloc.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();
}

class TransactionsInitialState extends TransactionsState {
  @override
  List<Object> get props => [];
}

class TransactionsLoadingErrorState extends TransactionsState {
  @override
  List<Object> get props => [];
}

class TransactionsLoadedState extends TransactionsState {
  List<TransactionModel> allTransactions;

  TransactionsLoadedState(this.allTransactions);

  @override
  List<Object> get props => [];
}
