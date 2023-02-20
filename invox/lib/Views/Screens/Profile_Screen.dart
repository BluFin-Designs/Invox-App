import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../Widgets/Profile_card.dart';
import '../Widgets/pie_chart.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(30.0)),
                color: Color(0xFFFF7B54),
              ),
              height: 350.0,
              child: Stack(
                children: [
                  Positioned(
                    right: 0.0,
                    bottom: -195.0,
                    child: Container(
                      height: 292.0,
                      width: 292.0,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 178, 107, 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(146.0)),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -65.0,
                    bottom: -15.0,
                    child: Container(
                      height: 182.0,
                      width: 182.0,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 178, 107, 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(91.0)),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            )),
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: 55,
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1464863979621-258859e62245?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2786&q=80"),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Hi, Emily Wills!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You\'re an ',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFFD9D9D9),
                            ),
                          ),
                          Text(
                            'Impulsive Buyer',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFFF80000),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      const Text(
                        'Your Buying Streak',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 20.0,
                            margin: const EdgeInsets.only(
                                left: 7.0, top: 10.0, right: 7.0, bottom: 10.0),
                            color: Colors.white,
                            child: Column(
                              children: [],
                            ),
                          ),
                          Text(
                            '20 Days',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ProfileCard(
                    colour: const Color(0xFFFF7B54),
                    title: 'MONTHLY',
                    title2: 'BUDGET BALANCE',
                    graph: Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                              startDegreeOffset: -90,
                              sectionsSpace: 0,
                              centerSpaceRadius: 37,
                              sections: getSections,
                            ),
                          ),
                        ),
                        Text(
                          '49%',
                          style: TextStyle(color: Colors.white, fontSize: 11.0),
                        ),
                      ],
                    ),
                    text: '₹ ',
                    text_colour: const Color(0xFFFFB26B),
                    bottom_text: '980 ',
                    bottom_text2: 'of 2000',
                  ),
                ),
                Expanded(
                  child: ProfileCard(
                    colour: Color(0xFFFFB26B),
                    title: 'SAVED',
                    title2: 'THIS MONTH',
                    graph: Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                              startDegreeOffset: -90,
                              sectionsSpace: 0,
                              centerSpaceRadius: 37,
                              sections: getSections1,
                            ),
                          ),
                        ),
                        const Text(
                          '64%',
                          style: TextStyle(color: Colors.white, fontSize: 11.0),
                        ),
                      ],
                    ),
                    text: '₹ ',
                    text_colour: const Color(0xFFFF7B54),
                    bottom_text: '1280 ',
                    bottom_text2: 'of 2000',
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
              ],
            ),
            Row(
              children: const [
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  'Personal Details',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFC1C1C1),
                      blurRadius: 4,
                      offset: Offset(4, 4), // Shadow position
                    ),
                  ],
                  color: Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                margin:
                    EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
                child: Stack(
                  children: [
                    const Positioned(
                      right: 8.0,
                      top: 8.0,
                      child: CircleAvatar(
                        backgroundColor: Color(0xFFC1C1C1),
                        child: Image(
                          image: AssetImage('assets/images/Vector.png'),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 13.0,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFF706F6F),
                              ),
                            ),
                            SizedBox(
                              width: 230.0,
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              'Emily Wills',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              'Email Address',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFF706F6F),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              'willsemily@example.com',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              'Gender',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFF706F6F),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              'Female',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
