import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Wallet_Slider extends StatefulWidget {
  const Wallet_Slider({
    Key? key,
    required this.wallets,
  }) : super(key: key);

  final List<Map<String, dynamic>> wallets;

  @override
  State<Wallet_Slider> createState() => _Wallet_SliderState();
}

class _Wallet_SliderState extends State<Wallet_Slider> {
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
                    vertical: 10.0,
                    horizontal: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 2,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  blurRadius: 2,
                                  offset: Offset(4, 4),
                                ),
                              ],
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
                                color: const Color.fromRGBO(255, 178, 107, .5),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -150,
                            right: -150,
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: const Color.fromRGBO(255, 178, 107, .5),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 30,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  element["name"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '??? ${element["value"].toStringAsFixed(2)}',
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
                                (!element["name"].contains("Card"))
                                    ? 'assets/images/money_bag.png'
                                    : 'assets/images/credit_card.png',
                              ),
                              height: 100.0,
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
}
