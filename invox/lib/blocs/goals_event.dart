part of 'goals_bloc.dart';

abstract class GoalsEvent extends Equatable {
  const GoalsEvent();
}

class GoalLoadingEvent extends GoalsEvent {
  @override
  List<Object> get props => [];
}

class GoalLoadingErrorEvent extends GoalsEvent {
  @override
  List<Object> get props => [];
}

class GoalLoadedEvent extends GoalsEvent {
  @override
  List<Object> get props => [];
}

class GoalRefreshEvent extends GoalsEvent {
  @override
  List<Object> get props => [];
}