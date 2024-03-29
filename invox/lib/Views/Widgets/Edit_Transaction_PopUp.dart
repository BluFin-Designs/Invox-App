import 'package:flutter/material.dart';
import 'package:invox/Models/Transaction_Model.dart';

import '../../Repositories/TransactionRepository.dart';
import '../../Models/CategoryModel.dart';
import '../../Repositories/CategoryRepository.dart';
import '../../Models/WalletModel.dart';
import '../../Repositories/WalletRepository.dart';

class EditTransactionPopUp extends StatefulWidget {
  //Todo:accept transaction model to be edited

  final TransactionModel txn;
  const EditTransactionPopUp({required this.txn, Key? key}) : super(key: key);

  @override
  State<EditTransactionPopUp> createState() => _EditTransactionPopUpState();
}

class _EditTransactionPopUpState extends State<EditTransactionPopUp> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amtController = TextEditingController();
  late double previousAmt;

  String txnType = "";
  int txnIcon = Icons.movie_creation.codePoint;
  DateTime _selectedDate = DateTime.now();
  late TransactionCategoryModel category;
  CategoryRepository categoryRepo = CategoryRepository();
  late List<TransactionCategoryModel> allCategories =
      categoryRepo.getCategories();
  late Wallet wallet;
  WalletRepository walletRepo = WalletRepository();
  late List<Wallet> allWallets = walletRepo.getWallets() as List<Wallet>;
  String uuid = "";

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
  void initState() {
    titleController.text = widget.txn.title;
    descController.text = widget.txn.description!;
    amtController.text = widget.txn.amount!.toString();
    txnType = widget.txn.txnType.toString();
    _selectedDate = widget.txn.date!;
    txnIcon = widget.txn.icons;
    wallet = widget.txn.wallet!;
    category = widget.txn.category;
    uuid = widget.txn.uid!;
    previousAmt = widget.txn.amount!;
    //wallet=widget.txn.wallet;
    super.initState();
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
                    wallet = value as Wallet;
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
                        category = value as TransactionCategoryModel;
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
                      items: <int>[
                        Icons.movie_creation.codePoint,
                        Icons.shopping_basket.codePoint,
                        Icons.import_contacts.codePoint,
                        Icons.label_important.codePoint,
                      ].map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                            value: value,
                            child: Icon(
                              IconData(
                                value,
                                fontFamily: 'MaterialIcons',
                              ),
                              color: Colors.white,
                            ));
                      }).toList(),
                      onChanged: (Object? value) {
                        setState(() {
                          txnIcon = value as int;
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
                    .editTransaction(
                        uuid,
                        titleController.text,
                        descController.text,
                        _selectedDate,
                        double.parse(amtController.text),
                        txnType,
                        wallet,
                        category,
                        txnIcon,
                        previousAmt)
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
                  "Edit",
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
