import 'package:hive/hive.dart';

import '../utils/Categories_Database.dart';
import '../Models/CategoryModel.dart';

class CategoryRepository {
  var mainBox = Hive.box("database");

  CategoryRepository() {
    List<TransactionCategoryModel> allCategories =
        mainBox.get("categories")?.cast<TransactionCategoryModel>() ?? [];
    if (allCategories.isEmpty) {
      mainBox.put("categories", CategoriesDatabase.categories);
      print("Added default categories!");
    }
  }

  List<TransactionCategoryModel> getCategories() {
    List<TransactionCategoryModel> allCategories =
        mainBox.get("categories")?.cast<TransactionCategoryModel>() ?? [];
    return allCategories;
  }

  //Add Category :-
  Future<bool> addCategories(TransactionCategoryModel category) async {
    try {
      // WalletsDatabase.wallets.add(wallet);
      List<TransactionCategoryModel> allCategories =
          mainBox.get("categories")?.cast<TransactionCategoryModel>();
      allCategories.add(category);
      mainBox.put("categories", allCategories);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  //Delete Category :-
  Future<bool> deleteCategory(String uuid) async {
    try {
      List<TransactionCategoryModel> allCategories =
          mainBox.get("categories")?.cast<TransactionCategoryModel>();
      allCategories.removeWhere((category) => category.Uid == uuid);
      mainBox.put("transactions", allCategories);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
