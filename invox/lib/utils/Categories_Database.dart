import 'package:flutter/material.dart';
import '../Models/CategoryModel.dart';

class CategoriesDatabase {
  static List<TransactionCategoryModel> categories = [
    TransactionCategoryModel(
      Uid: "1f23a7d0-02e9-11ee-9242-651e1c089bba",
      title: "Essential Items",
      color: 0xff5269B3,
      icon: Icons.label_important.codePoint,
    ),
    TransactionCategoryModel(
      Uid: "1f244410-02e9-11ee-9242-651e1c089bba",
      title: "Entertainment",
      color: 0xff91D8E4,
      icon: Icons.movie.codePoint,
    ),
    TransactionCategoryModel(
      Uid: "1f244411-02e9-11ee-9242-651e1c089bba",
      title: "Extras",
      color: 0xff8EA7E9,
      icon: Icons.shopping_bag.codePoint,
    ),
  ];
}
