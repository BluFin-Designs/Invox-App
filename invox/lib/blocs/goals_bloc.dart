import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../Models/SavingGoalsModel.dart';
import '../Repositories/SavingGoalsRepository.dart';

part 'goals_event.dart';
part 'goals_state.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  GoalsBloc() : super(GoalsInitialState()) {
    SavingGoalsRepository goalRepo = SavingGoalsRepository();
    List<SavingGoalsModel> allGoals = [];

    on<GoalsEvent>((event, emit) async {
      if (event is GoalLoadingEvent) {
        //Load-Data
        try {
          allGoals = await goalRepo.getGoals();
          emit(GoalsLoadedState(allGoals));
        } catch (err) {
          emit(GoalsLoadingErrorState());
        }
      } else if (event is GoalLoadedEvent) {
        emit(GoalsLoadedState(allGoals));
      } else {
        emit(GoalsLoadingErrorState());
      }
    });
  }
}
