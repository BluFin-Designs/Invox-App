import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invox/Repositories/BudgetRepository.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetRepository budgetRepo = BudgetRepository();
  BudgetCubit() : super(BudgetInitialState()) {
    emit(BudgetLoadingState());
    Map<dynamic, dynamic> budgets = budgetRepo.getBudgets();
    emit(BudgetLoadedState(budgets["monthly"]!, budgets["weekly"]!));
  }

  // updateBudget(budgetType type, double value) async {
  //   emit(BudgetLoadingState());
  //   Map<String, double> budgets = await budgetRepo.updateBudget(type, value);
  //   emit(BudgetLoadedState(budgets["monthly"]!, budgets["weekly"]!));
  // }

  updateData() {
    emit(BudgetLoadingState());
    Map<dynamic, dynamic> budgets = budgetRepo.getBudgets();
    emit(BudgetLoadedState(budgets["monthly"]!, budgets["weekly"]!));
  }
}
