import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invox/Models/Transaction_Model.dart';

import '../Repositories/BudgetRepository.dart';
import '../Repositories/TransactionRepository.dart';
import '../Repositories/UserRepository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    // UserRepository userRepo = UserRepository();
    TransactionRepository txnRepo = TransactionRepository();
    BudgetRepository budgetRepo = BudgetRepository();

    on<ProfileEvent>((event, emit) async {
      if (event is ProfileLoadingEvent) {
        emit(ProfileLoadingState());
        //get userinfo
        UserModel userinfo = UserRepository.user!;

        //get this month/week total spent
        List<TransactionModel> txns = await txnRepo.getTransactions();
        double thisMonthTotal = 0;
        double thisWeekTotal = 0;
        DateTime today = DateTime.now();
        DateTime lastSevenDays = today.subtract(const Duration(days: 6));
        for (var txn in txns) {
          DateTime currentDate = txn.date as DateTime;

          //getting this week's transactions
          if ((currentDate.isAfter(lastSevenDays) ||
                  currentDate.isAtSameMomentAs(lastSevenDays)) &&
              txn.txnType != TransactionType.CREDIT) {
            // print(txn.txnType.toString());
            thisWeekTotal += txn.amount!;
          }
          //getting this month's transactions
          if (txn.date?.month == today.month &&
              txn.txnType == TransactionType.DEBIT) {
            thisMonthTotal += txn.amount!;
          }
        }

        //get budgets
        Map<dynamic, dynamic> budgets = budgetRepo.getBudgets();

        // getting Streaks
        int streaks = _getStreaks(txns);

        emit(ProfileLoadedState(
          userInfo: userinfo,
          monthlyBudget: budgets["monthly"],
          weeklyBudget: budgets["weekly"],
          monthTotalSpent: thisMonthTotal,
          weekTotalSpent: thisWeekTotal,
          buyingStreak: streaks,
        ));
      }
    });
  }

  // Get streaks
  int _getStreaks(List<TransactionModel> txns) {
    int streak = 0;

    DateTime today = DateTime.now();
    for (int i = 0; i < 30; i++) {
      DateTime currentDate = today.subtract(Duration(days: i));
      int flag = 0;
      for (var txn in txns) {
        if ((txn.date?.day == currentDate.day) &&
            (txn.date?.month == currentDate.month) &&
            (txn.date?.year == currentDate.year) &&
            (txn.txnType == TransactionType.DEBIT)) {
          streak = i + 1;
          flag = 1;
          break;
        }
      }
      if (flag == 0) {
        break;
      }
    }

    return streak;
  }
}
