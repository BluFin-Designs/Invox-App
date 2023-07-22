import 'package:hive/hive.dart';

import 'GoalsTransactionModel.dart';
part 'SavingGoalsModel.g.dart';

@HiveType(typeId: 4)
class SavingGoalsModel {
  @HiveField(0)
  String uid;
  @HiveField(1)
  String title;
  @HiveField(2)
  List<GoalsTransactionModel> txn;
  @HiveField(3)
  double requiredAmount;
  SavingGoalsModel(
      {required this.uid,
      required this.title,
      required this.txn,
      required this.requiredAmount});
}
