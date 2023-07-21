part of 'goals_bloc.dart';

abstract class GoalsState extends Equatable {
  const GoalsState();
}

class GoalsInitialState extends GoalsState {
  @override
  List<Object> get props => [];
}

class GoalsLoadingErrorState extends GoalsState {
  @override
  List<Object> get props => [];
}

class GoalsLoadedState extends GoalsState {
  List<SavingGoalsModel> allGoals;

  GoalsLoadedState(this.allGoals);

  @override
  List<Object> get props => [];
}
