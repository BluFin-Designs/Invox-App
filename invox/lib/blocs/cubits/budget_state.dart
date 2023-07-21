part of 'budget_cubit.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();
}

class BudgetInitialState extends BudgetState {
  @override
  List<Object> get props => [];
}

class BudgetLoadingState extends BudgetState {
  @override
  List<Object> get props => [];
}

class BudgetLoadedState extends BudgetState {
  double monthly;
  double weekly;

  BudgetLoadedState(this.monthly, this.weekly);
  @override
  List<Object> get props => [];
}
