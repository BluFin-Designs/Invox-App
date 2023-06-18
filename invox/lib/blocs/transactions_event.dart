part of 'transactions_bloc.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();
}

class TransactionLoadingEvent extends TransactionsEvent {
  @override
  List<Object> get props => [];
}

class TransactionLoadingErrorEvent extends TransactionsEvent {
  @override
  List<Object> get props => [];
}

class TransactionLoadedEvent extends TransactionsEvent {
  @override
  List<Object> get props => [];
}

class TransactionRefreshEvent extends TransactionsEvent {
  @override
  List<Object> get props => [];
}
