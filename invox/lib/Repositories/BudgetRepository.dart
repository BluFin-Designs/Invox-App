import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum budgetType { MONTH, WEEK }

class BudgetRepository {
  var mainBox = Hive.box("database");

  BudgetRepository() {
    Map<dynamic, dynamic> budgets = mainBox.get("budgets") ?? {};
    if (budgets.isEmpty) {
      mainBox.put("budgets", {
        "monthly": 20000.0,
        "weekly": 5000.0,
      });
      debugPrint("Added default budgets!");
    }
  }

  Map<dynamic, dynamic> getBudgets() {
    Map<dynamic, dynamic> budgets = mainBox.get("budgets");
    return budgets;
  }

  Future<Map<dynamic, dynamic>> updateBudget(
      budgetType type, double value) async {
    Map<dynamic, dynamic> budgets = mainBox.get("budgets");
    if (type == budgetType.WEEK) {
      budgets["weekly"] = value;
    } else {
      budgets["monthly"] = value;
    }
    mainBox.put("budgets", budgets);
    return budgets;
  }
}
