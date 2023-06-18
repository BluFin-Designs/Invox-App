import 'package:hive/hive.dart';

part 'CategoryModel.g.dart';

@HiveType(typeId: 2)
class TransactionCategoryModel {
  @HiveField(0)
  String Uid;

  @HiveField(1)
  int icon;

  @HiveField(2)
  int color;

  @HiveField(3)
  String title;

  TransactionCategoryModel(
      {required this.title,
      required this.color,
      required this.icon,
      required this.Uid});
}
