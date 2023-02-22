import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../Widgets/Profile_Stats_Card.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(40),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 400,
                    color: const Color(0xFFFF7B54),
                  ),
                  Positioned(
                    bottom: -5,
                    right: -80,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 178, 107, .5),
                          borderRadius: BorderRadius.circular(200)),
                    ),
                  ),
                  Positioned(
                    bottom: -200,
                    right: 10,
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 178, 107, .5),
                          borderRadius: BorderRadius.circular(200)),
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        const Text(
                          'Hi, Emily Wills!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
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
                        Row(
                          children: const [
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Your Buying Streak',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Container(
                                height: 14,
                                child: RotatedBox(
                                  quarterTurns: -3,
                                  child: AspectRatio(
                                    aspectRatio: 0.05,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xffF0F0F0),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: BarChart(
                                          BarChartData(
                                            barGroups: [
                                              BarChartGroupData(
                                                x: 0,
                                                barRods: [
                                                  BarChartRodData(
                                                    width: 10,
                                                    toY: 20,
                                                    gradient: _barsGradient,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            gridData: FlGridData(
                                                drawHorizontalLine: false,
                                                drawVerticalLine: false),
                                            alignment:
                                                BarChartAlignment.spaceAround,
                                            maxY: 31,
                                            barTouchData: BarTouchData(
                                                enabled: false,
                                                touchTooltipData:
                                                    BarTouchTooltipData(
                                                  tooltipBgColor:
                                                      Colors.transparent,
                                                  tooltipPadding:
                                                      EdgeInsets.zero,
                                                  tooltipMargin: 8,
                                                  getTooltipItem: (
                                                    BarChartGroupData group,
                                                    int groupIndex,
                                                    BarChartRodData rod,
                                                    int rodIndex,
                                                  ) {
                                                    return BarTooltipItem(
                                                      rod.toY
                                                          .round()
                                                          .toString(),
                                                      const TextStyle(
                                                          color:
                                                              Color(0xFFFF7B54),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    );
                                                  },
                                                )),
                                            titlesData: titlesData,
                                            borderData: FlBorderData(
                                              show: true,
                                              border: const Border(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              '20 Days',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  ProfileStatsCard(
                    color_1: Theme.of(context).primaryColor,
                    color_2: Theme.of(context).accentColor,
                    value_1: 980.0,
                    value_2: 2000.0,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  ProfileStatsCard(
                    color_1: Theme.of(context).accentColor,
                    color_2: Theme.of(context).primaryColor,
                    value_1: 1280.0,
                    value_2: 2000.0,
                  ),
                ],
              ),
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
            Container(
              height: 170,
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
              margin: const EdgeInsets.only(
                  left: 20, top: 15, right: 20, bottom: 15),
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
                              fontWeight: FontWeight.bold,
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
                              fontWeight: FontWeight.bold,
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Color(0xffFF7B54),
          Color(0xFF0A2647),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
  FlTitlesData get titlesData => FlTitlesData(
        show: false,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );
}
