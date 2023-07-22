import '../Models/SavingGoalsModel.dart';
import '../Models/GoalsTransactionModel.dart';
import 'package:hive/hive.dart';

class SavingGoalsRepository {
  var mainBox = Hive.box("database");
  Future<List<SavingGoalsModel>> getGoals() async {
    List<SavingGoalsModel> allGoals =
        mainBox.get("goals")?.cast<SavingGoalsModel>() ?? [];
    return allGoals;
  }

  Future<bool> addGoals(SavingGoalsModel goal) async {
    try {
      List<SavingGoalsModel> allGoals =
          mainBox.get("goals")?.cast<SavingGoalsModel>() ?? [];
      allGoals.add(goal);
      mainBox.put("goals", allGoals);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> editGoals(
    String uui,
    String title,
    List<GoalsTransactionModel> txn,
    double requiredAmount,
  ) async {
    SavingGoalsModel tempGoals = SavingGoalsModel(
        uid: uui, title: title, txn: txn, requiredAmount: requiredAmount);

    try {
      List<SavingGoalsModel> allGoals =
          mainBox.get("goals")?.cast<SavingGoalsModel>() ?? [];
      final index =
          allGoals.indexWhere((element) => element.uid == tempGoals.uid);
      allGoals[index] = tempGoals;
      mainBox.put("goals", allGoals);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteGoals(String uui) async {
    try {
      List<SavingGoalsModel> allGoals =
          mainBox.get("goals")?.cast<SavingGoalsModel>() ?? [];
      allGoals.removeWhere((goals) => goals.uid == uui);
      mainBox.put("goals", allGoals);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
