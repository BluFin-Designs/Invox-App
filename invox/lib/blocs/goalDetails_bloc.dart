import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invox/Models/SavingGoalsModel.dart';


import '../Repositories/GoalDetailsRepository.dart';

part 'goalDetails_event.dart';
part 'goalDetails_state.dart';

class GoalDetailsBloc extends Bloc<GoalDetailsEvent, GoalDetailsState> {
  GoalDetailsBloc() : super(GoalDetailsInitialState()) {
    GoalDetailsRepository goalTxnRepo = GoalDetailsRepository();
    SavingGoalsModel? allGoalsTxn;

    on<GoalDetailsEvent>((event, emit) async {
      if (event is GoalDetailsLoadingEvent) {
        //Load-Data
        try {
          allGoalsTxn = await goalTxnRepo.getGoalDetails(event.uuid);
          emit(GoalDetailsLoadedState(allGoalsTxn!));
        } catch (err) {
          emit(GoalDetailsLoadingErrorState());
        }
      } else if (event is GoalDetailsLoadedEvent) {
        emit(GoalDetailsLoadedState(allGoalsTxn!));
      } else {
        emit(GoalDetailsLoadingErrorState());
      }
    });
  }
}
