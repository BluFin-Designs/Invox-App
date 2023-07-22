import 'package:hive/hive.dart';

part 'GoalsTransactionModel.g.dart';

@HiveType(typeId: 5)
class GoalsTransactionModel {
  @HiveField(0)
  String uid;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  double amount;
  GoalsTransactionModel(
      {required this.uid, required this.date, required this.amount});
}
