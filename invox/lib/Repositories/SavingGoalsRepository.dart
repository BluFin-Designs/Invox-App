import '../Models/SavingGoalsModel.dart';
import '../utils/SavingGoals_Database.dart';
import '../Models/GoalsTransactionModel.dart';

class SavingGoalsRepository {
  Future<List<SavingGoalsModel>> getGoals() async {
    return SavingGoalsDatabase.goals;
  }

  Future<bool> addGoals(SavingGoalsModel goal) async {
    try {
      SavingGoalsDatabase.goals.add(goal);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<SavingGoalsModel> editGoals(
    String uui,
    String title,
    List<GoalsTransactionModel> txn,
    double requiredAmount,
  ) async {
    SavingGoalsModel tempGoals = SavingGoalsModel(
        uid: uui, title: title, txn: txn, requiredAmount: requiredAmount);

    try {
      final index = SavingGoalsDatabase.goals
          .indexWhere((element) => element.uid == tempGoals.uid);
      SavingGoalsDatabase.goals[index] = tempGoals;
      return tempGoals;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteGoals(String uui) async {
    try {
      SavingGoalsDatabase.goals.removeWhere((goals) => goals.uid == uui);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
