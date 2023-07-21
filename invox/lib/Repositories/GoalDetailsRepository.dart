import '../Models/GoalsTransactionModel.dart';
import '../Models/SavingGoalsModel.dart';
import 'package:hive/hive.dart';

class GoalDetailsRepository {
  var mainBox = Hive.box("database");
  Future<SavingGoalsModel?> getGoalDetails(String uuid) async {
    List<SavingGoalsModel> allGoals =
        mainBox.get("goals")?.cast<SavingGoalsModel>() ?? [];
    return allGoals.firstWhere((element) => element.uid == uuid);
  }

  Future<bool> addGoalDetails(
      GoalsTransactionModel goalTxn, String uuid) async {
    try {
      List<SavingGoalsModel> allGoals =
          mainBox.get("goals")?.cast<SavingGoalsModel>() ?? [];
      allGoals.firstWhere((element) => element.uid == uuid).txn.add(goalTxn);
      mainBox.put("goals", allGoals);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> editGoalsTransaction(
      GoalsTransactionModel goalTxn, String uuid) async {
    GoalsTransactionModel tempGoalsTxn = GoalsTransactionModel(
        uid: goalTxn.uid, amount: goalTxn.amount, date: goalTxn.date);

    try {
      List<SavingGoalsModel> allGoals =
          mainBox.get("goals")?.cast<SavingGoalsModel>() ?? [];
      final index = allGoals
          .firstWhere((element) => element.uid == uuid)
          .txn
          .indexWhere((element) => element.uid == tempGoalsTxn.uid);
      allGoals.firstWhere((element) => element.uid == uuid).txn[index] =
          tempGoalsTxn;
      mainBox.put("goals", allGoals);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteGoalsTxn(String uui, String txnUuid) async {
    try {
      List<SavingGoalsModel> allGoals =
          mainBox.get("goals")?.cast<SavingGoalsModel>() ?? [];
      allGoals
          .firstWhere((element) => element.uid == uui)
          .txn
          .removeWhere((goalsTxn) => goalsTxn.uid == txnUuid);
      mainBox.put("goals", allGoals);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
