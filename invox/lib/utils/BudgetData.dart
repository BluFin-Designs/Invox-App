enum Budget { weekly, monthly }

class BudgetData {
  static List<Map<String, dynamic>> allCategories = [
    {
      "id": Budget.monthly,
      "title": "Monthly Budget",
      "Amount": 8400.00,
    },
    {
      "id": Budget.weekly,
      "title": "Weekly Budget",
      "Amount": 5000.00,
    },
  ];

  static void modifyData(Budget budgetId, double amt) {
    List<Map<String, dynamic>> newList = [];
    for (var element in allCategories) {
      if (element["id"] == budgetId) {
        element["Amount"] = amt;
        newList.add(element);
      } else {
        newList.add(element);
      }
    }

    allCategories = newList;
  }
}
