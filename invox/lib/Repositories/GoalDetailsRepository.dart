import '../Models/GoalsTransactionModel.dart';
import '../utils/SavingGoals_Database.dart';
import '../Models/SavingGoalsModel.dart';

class GoalDetailsRepository {
  Future<SavingGoalsModel?> getGoalDetails(String uuid) async {
    return SavingGoalsDatabase.goals
        .firstWhere((element) => element.uid == uuid);
  }

  Future<bool> addGoalDetails(
      GoalsTransactionModel goalTxn, String uuid) async {
    try {
      SavingGoalsDatabase.goals
          .firstWhere((element) => element.uid == uuid)
          .txn
          .add(goalTxn);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<GoalsTransactionModel> editGoalsTransaction(
      GoalsTransactionModel goalTxn, String uuid) async {
    GoalsTransactionModel tempGoalsTxn = GoalsTransactionModel(
        uid: goalTxn.uid, amount: goalTxn.amount, date: goalTxn.date);

    try {
      final index = SavingGoalsDatabase.goals
          .firstWhere((element) => element.uid == uuid)
          .txn
          .indexWhere((element) => element.uid == tempGoalsTxn.uid);
      SavingGoalsDatabase.goals
          .firstWhere((element) => element.uid == uuid)
          .txn[index] = tempGoalsTxn;
      return tempGoalsTxn;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteGoalsTxn(String uui, String txnUuid) async {
    try {
      SavingGoalsDatabase.goals
          .firstWhere((element) => element.uid == uui)
          .txn
          .removeWhere((goalsTxn) => goalsTxn.uid == txnUuid);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
