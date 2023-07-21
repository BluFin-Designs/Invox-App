import 'GoalsTransactionModel.dart';

class SavingGoalsModel {
  String uid;
  String title;
  List<GoalsTransactionModel> txn;
  double requiredAmount;
  SavingGoalsModel(
      {required this.uid,
      required this.title,
      required this.txn,
      required this.requiredAmount});
}
