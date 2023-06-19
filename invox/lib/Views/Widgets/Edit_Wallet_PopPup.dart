import 'package:invox/Models/WalletModel.dart';

import '../../Repositories/WalletRepository.dart';
import 'package:flutter/material.dart';

class EditWalletPopup extends StatefulWidget {
  final Wallet wallet;
  const EditWalletPopup({Key? key, required this.wallet}) : super(key: key);

  @override
  State<EditWalletPopup> createState() => _EditWalletPopupState();
}

class _EditWalletPopupState extends State<EditWalletPopup> {
  String uuid = "";

  var _name = "";
  double _amount = 0;
  int _color = Colors.white.value;
  _editWallet(String uui, String title, double amount, int color) {
    WalletRepository catRepo = WalletRepository();
    try {
      catRepo.editWallet(uui, title, amount, color).then(
            (value) => Navigator.pop(context),
          );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to edit Wallet!",
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void initState() {
    _name = widget.wallet.title;
    _amount = widget.wallet.amount;
    _color = widget.wallet.color;
    uuid = widget.wallet.Uid!;
    //wallet=widget.txn.wallet;
    super.initState();
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
                  hintText: _name,
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
                onChanged: (String tval) => _name = tval,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: _amount.toString(),
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
                  setState(() {
                    _amount = double.parse(
                      value.toString(),
                    );
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
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
                  items: <int>[
                    Colors.deepOrangeAccent.value,
                    Colors.blueAccent.value,
                    Colors.greenAccent.value,
                    Colors.purpleAccent.value,
                  ].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Container(
                        height: 30,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(value),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (Object? value) {
                    setState(() {
                      _color = value! as int;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF7286D3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  )),
              onPressed: () {
                _editWallet(
                  uuid,
                  _name,
                  _amount,
                  _color,
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
