import 'package:flutter/material.dart';
import '../Models/CategoryModel.dart';

class CategoriesDatabase {
  static List<TransactionCategoryModel> categories = [
    TransactionCategoryModel(
      Uid: "1f23a7d0-02e9-11ee-9242-651e1c089bba",
      title: "Essential Items",
      color: const Color(0xff5269B3),
      icon: Icons.label_important,
    ),
    TransactionCategoryModel(
      Uid: "1f244410-02e9-11ee-9242-651e1c089bba",
      title: "Entertainment",
      color: const Color(0xff91D8E4),
      icon: Icons.movie,
    ),
    TransactionCategoryModel(
      Uid: "1f244411-02e9-11ee-9242-651e1c089bba",
      title: "Extras",
      color: const Color(0xff8EA7E9),
      icon: Icons.shopping_bag,
    ),
  ];
}
