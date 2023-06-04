import '../utils/Categories_Database.dart';
import '../Models/CategoryModel.dart';

class CategoryRepository {
  List<TransactionCategoryModel> getCategories() {
    return CategoriesDatabase.categories;
  }

  //Add Category :-
  Future<bool> addCategories(TransactionCategoryModel category) async {
    try {
      CategoriesDatabase.categories.add(category);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  //Delete Category :-
  Future<bool> deleteCategory(String uuid) async {
    try {
      CategoriesDatabase.categories
          .removeWhere((category) => category.Uid == uuid);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
