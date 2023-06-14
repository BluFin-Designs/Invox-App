import 'package:flutter/material.dart';

import '../../Repositories/CategoryRepository.dart';
import '../../Models/CategoryModel.dart';
import 'package:uuid/uuid.dart';

class CategoryAddPopUp extends StatefulWidget {
  const CategoryAddPopUp({Key? key}) : super(key: key);

  @override
  State<CategoryAddPopUp> createState() => _CategoryAddPopUpState();
}

class _CategoryAddPopUpState extends State<CategoryAddPopUp> {
  var uuid = Uuid();

  late Color _newItemColor;
  late String _newItemTitle;
  late IconData _newItemIcon;

  _addNewCategory(BuildContext context, TransactionCategoryModel category) {
    CategoryRepository catRepo = CategoryRepository();
    try {
      catRepo
          .addCategories(category)
          .then((value) => Navigator.of(context).pop());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to add new Category!",
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: "Category Name",
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  fillColor: Color(0xff8EA7E9),
                  filled: true,
                ),
                onChanged: (value) {
                  _newItemTitle = value;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: DropdownButtonFormField(
                      dropdownColor: const Color(0xFF7286D3),
                      isDense: true,
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.white,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        focusColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        fillColor: Color(0xff8EA7E9),
                        filled: true,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      hint: const Text(
                        "Icon",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      items: <IconData>[
                        Icons.label_important_sharp,
                        Icons.movie,
                        Icons.menu_book_rounded,
                        Icons.shopping_bag,
                        Icons.shopping_basket,
                        Icons.sports_baseball,
                      ].map<DropdownMenuItem<IconData>>((IconData value) {
                        return DropdownMenuItem<IconData>(
                          value: value,
                          child: Icon(
                            value,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                      onChanged: (IconData? value) {
                        _newItemIcon = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: DropdownButtonFormField(
                      isDense: true,
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.white,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        focusColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        fillColor: Color(0xff8EA7E9),
                        filled: true,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      hint: const Text(
                        "Color",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      items: <Color>[
                        Colors.deepOrangeAccent,
                        Colors.blueAccent,
                        Colors.greenAccent,
                        Colors.purpleAccent,
                      ].map<DropdownMenuItem<Color>>((Color value) {
                        return DropdownMenuItem<Color>(
                          value: value,
                          child: Container(
                            height: 30,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: value,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (Color? value) {
                        _newItemColor = value!;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  )),
              onPressed: () => _addNewCategory(
                context,
                TransactionCategoryModel(
                  title: _newItemTitle,
                  color: _newItemColor.value,
                  icon: _newItemIcon.codePoint,
                  Uid: uuid.v1(),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 10,
                ),
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
