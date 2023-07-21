part of 'goalDetails_bloc.dart';

abstract class GoalDetailsEvent extends Equatable {
  const GoalDetailsEvent();
}

class GoalDetailsLoadingEvent extends GoalDetailsEvent {
  String uuid;
  GoalDetailsLoadingEvent(this.uuid);
  @override
  List<Object> get props => [];
}

class GoalDetailsLoadingErrorEvent extends GoalDetailsEvent {
  @override
  List<Object> get props => [];
}

class GoalDetailsLoadedEvent extends GoalDetailsEvent {
  @override
  List<Object> get props => [];
}

class GoalDetailsRefreshEvent extends GoalDetailsEvent {
  @override
  List<Object> get props => [];
}
