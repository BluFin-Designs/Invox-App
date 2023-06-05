import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../Repositories/TransactionRepository.dart';
import '../../Repositories/CategoryRepository.dart';
import '../../Repositories/WalletRepository.dart';
import '../../Models/CategoryModel.dart';
import '../../Models/WalletModel.dart';

class AddTransactionPopUp extends StatefulWidget {
  const AddTransactionPopUp({Key? key}) : super(key: key);

  @override
  State<AddTransactionPopUp> createState() => _AddTransactionPopUpState();
}

class _AddTransactionPopUpState extends State<AddTransactionPopUp> {
  var uuid = Uuid();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amtController = TextEditingController();

  String txnType = "";
  IconData txnIcon = Icons.movie_creation;
  DateTime _selectedDate = DateTime.now();
  late TransactionCategoryModel txnCategory;
  CategoryRepository categoryRepo = CategoryRepository();
  late List<TransactionCategoryModel> allCategories =
      categoryRepo.getCategories();
  late Wallet txnWallet;
  WalletRepository walletRepo = WalletRepository();
  late List<Wallet> allWallets = walletRepo.getWallets();

  Future<void> _selectDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
      context: ctx,
      initialDate: _selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Form(
        child: Column(
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
                controller: titleController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  fillColor: Color(0xff8EA7E9),
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: TextFormField(
                controller: descController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  fillColor: Color(0xff8EA7E9),
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: TextFormField(
                controller: amtController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  prefixText: "₹ ",
                  hintText: "Amount",
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  fillColor: Color(0xff8EA7E9),
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: SizedBox(
                child: DropdownButtonFormField(
                  isDense: true,
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.white,
                  ),
                  dropdownColor: const Color(0xFFFF7B54),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    focusColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        style: BorderStyle.solid,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        style: BorderStyle.solid,
                      ),
                    ),
                    fillColor: Color(0xff8EA7E9),
                    filled: true,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  hint: const Text(
                    "Wallet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  items:
                      allWallets.map<DropdownMenuItem<Wallet>>((Wallet value) {
                    return DropdownMenuItem<Wallet>(
                      value: value,
                      child: Text(
                        value.title,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (Object? value) {
                    txnWallet = value as Wallet;
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: SizedBox(
                    width: 180,
                    child: DropdownButtonFormField(
                      isDense: true,
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.white,
                      ),
                      dropdownColor: const Color(0xFFFF7B54),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        focusColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        fillColor: Color(0xff8EA7E9),
                        filled: true,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      hint: const Text(
                        "Category",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      items: allCategories
                          .map<DropdownMenuItem<TransactionCategoryModel>>(
                              (TransactionCategoryModel value) {
                        return DropdownMenuItem<TransactionCategoryModel>(
                          value: value,
                          child: Text(
                            value.title,
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                      onChanged: (Object? value) {
                        txnCategory = value as TransactionCategoryModel;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: SizedBox(
                    width: 120,
                    child: DropdownButtonFormField(
                      isDense: true,
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.white,
                      ),
                      dropdownColor: const Color(0xFFFF7B54),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        focusColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        fillColor: Color(0xff8EA7E9),
                        filled: true,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      hint: const Text(
                        "Credit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      items: <String>[
                        "Credit",
                        "Debit",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                      onChanged: (Object? value) {
                        setState(() {
                          txnType = value.toString();
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: SizedBox(
                    width: 180,
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Color(0xff8EA7E9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "${_selectedDate.toLocal()}"
                                      .split(' ')[0]
                                      .replaceAll("-", "/"),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                              ),
                              IconButton(
                                onPressed: () => _selectDate(context),
                                icon: const Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: SizedBox(
                    width: 120,
                    child: DropdownButtonFormField(
                      isDense: true,
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.white,
                      ),
                      dropdownColor: const Color(0xFFFF7B54),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        focusColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                          ),
                        ),
                        fillColor: Color(0xff8EA7E9),
                        filled: true,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      hint: const Icon(
                        Icons.movie_creation,
                        color: Colors.white,
                      ),
                      items: <IconData>[
                        Icons.movie_creation,
                        Icons.shopping_basket,
                        Icons.import_contacts,
                        Icons.label_important,
                      ].map<DropdownMenuItem<IconData>>((IconData value) {
                        return DropdownMenuItem<IconData>(
                          value: value,
                          child: Icon(
                            value,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                      onChanged: (Object? value) {
                        setState(() {
                          txnIcon = value as IconData;
                        });
                      },
                    ),
                  ),
                )
              ],
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
              onPressed: () {
                TransactionRepository()
                    .addTransaction(
                        uuid.v1(),
                        titleController.text,
                        descController.text,
                        _selectedDate,
                        double.parse(amtController.text),
                        txnType,
                        txnWallet,
                        txnCategory,
                        txnIcon)
                    .then(
                      (value) => Navigator.pop(context),
                    );
              },
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
