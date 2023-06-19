import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:invox/Models/WalletModel.dart';
import 'Edit_Wallet_PopPup.dart';

class Wallet_Slider extends StatefulWidget {
  Wallet_Slider(
      {Key? key,
      required this.wallets,
      required this.refresh,
      required this.deleteFunction})
      : super(key: key);
  final List<Wallet> wallets;
  Function refresh;
  Function(String) deleteFunction;

  @override
  State<Wallet_Slider> createState() => _Wallet_SliderState();
}

enum menuOptions { EDIT, DELETE }

menuOptions selectedOption = menuOptions.EDIT;

class _Wallet_SliderState extends State<Wallet_Slider> {
  var _popupMenuItemIndex = 0;
  int _currState = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 200.0,
              viewportFraction: 1,
              padEnds: true,
              onPageChanged: (val, _) {
                setState(() {
                  _currState = val;
                });
              }),
          items: widget.wallets.map((element) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 14),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Positioned(
                            bottom: -180,
                            right: -50,
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: const Color.fromRGBO(142, 167, 233, .5),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -140,
                            right: -140,
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: const Color.fromRGBO(142, 167, 233, .5),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  element.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '₹ ${element.amount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            right: 30,
                            child: Image(
                              image: AssetImage(
                                (!element.title.contains("Card"))
                                    ? 'assets/images/money_bag.png'
                                    : 'assets/images/credit_card.png',
                              ),
                              height: 100.0,
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: PopupMenuButton(
                                  onSelected: (value) {
                                    _onMenuItemSelected(value as int);
                                  },
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  itemBuilder: (BuildContext ctx) => [
                                    PopupMenuItem(
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      value: menuOptions.EDIT.index,
                                    ),
                                    PopupMenuItem(
                                      child: Text("Delete",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      value: menuOptions.DELETE.index,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 10,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    height: 10,
                    width: (i == _currState) ? 40 : 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor),
                  ),
                );
              },
              itemCount: widget.wallets.length,
            ),
          ),
        )
      ],
    );
  }

  _onMenuItemSelected(int value) {
    setState(() {
      _popupMenuItemIndex = value;
    });

    if (value == menuOptions.EDIT.index) {
      showDialog(
          barrierDismissible: false,
          useSafeArea: true,
          context: context,
          builder: (context) => Dialog(
                insetPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 370,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Edit Wallet",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        EditWalletPopup(wallet: widget.wallets[_currState])
                      ],
                    ),
                  ),
                ),
              )).then((value) => widget.refresh);
    } else if (value == menuOptions.DELETE.index) {
      widget.deleteFunction(widget.wallets[_currState].Uid);
    }
  }
}
