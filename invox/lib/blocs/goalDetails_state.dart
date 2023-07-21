part of 'goalDetails_bloc.dart';

abstract class GoalDetailsState extends Equatable {
  const GoalDetailsState();
}

class GoalDetailsInitialState extends GoalDetailsState {
  @override
  List<Object> get props => [];
}

class GoalDetailsLoadingErrorState extends GoalDetailsState {
  @override
  List<Object> get props => [];
}

class GoalDetailsLoadedState extends GoalDetailsState {
  SavingGoalsModel goalDetails;

  GoalDetailsLoadedState(this.goalDetails);

  @override
  List<Object> get props => [];
}
