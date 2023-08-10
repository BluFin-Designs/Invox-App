import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invox/Views/Screens/LoginSignUp_Screen.dart';
import 'package:invox/blocs/cubits/auth_cubit.dart';
import 'package:invox/blocs/profile_bloc.dart';

import '../../Repositories/UserRepository.dart';
import '../Widgets/Profile_Stats_Card.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';
  Profile({Key? key}) : super(key: key);

  String _getBuyerRating(int streak) {
    if (streak <= 10) {
      return "Normal";
    } else if (streak > 10 && streak <= 20) {
      return "impulsive";
    } else {
      return "Extreme";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          // debugPrint(state.toString());
          if (state is ProfileInitialState) {
            BlocProvider.of<ProfileBloc>(context).add(ProfileLoadingEvent());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoadedState) {
            debugPrint(state.buyingStreak.toString());
            return SingleChildScrollView(
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
                          color: const Color(0xFF7286D3),
                        ),
                        Positioned(
                          bottom: -5,
                          right: -80,
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(142, 167, 233, .5),
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
                                color: const Color.fromRGBO(142, 167, 233, .5),
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
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  maxRadius: 55,
                                  backgroundImage: NetworkImage(UserRepository
                                      .user?.profileImg as String),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Hi, ${UserRepository.user?.name as String}!",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'You\'re an ',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Color(0xFFD9D9D9),
                                    ),
                                  ),
                                  Text(
                                    _getBuyerRating(state.buyingStreak),
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Color(0xFF91D8E4),
                                    ),
                                  ),
                                  const Text(
                                    ' Buyer',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Color(0xFFD9D9D9),
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
                                      fontSize: 16.0,
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
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: BarChart(
                                                BarChartData(
                                                  barGroups: [
                                                    BarChartGroupData(
                                                      x: 0,
                                                      barRods: [
                                                        BarChartRodData(
                                                          width: 10,
                                                          toY: state
                                                                  .buyingStreak
                                                                  .toDouble() +
                                                              1,
                                                          gradient:
                                                              _barsGradient,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                  gridData: FlGridData(
                                                      drawHorizontalLine: false,
                                                      drawVerticalLine: false),
                                                  alignment: BarChartAlignment
                                                      .spaceAround,
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
                                                          BarChartGroupData
                                                              group,
                                                          int groupIndex,
                                                          BarChartRodData rod,
                                                          int rodIndex,
                                                        ) {
                                                          return BarTooltipItem(
                                                            rod.toY
                                                                .round()
                                                                .toString(),
                                                            const TextStyle(
                                                                color: Color(
                                                                    0xFF7286D3),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
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
                                  Text(
                                    '${state.buyingStreak} Days',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 45,
                          left: 10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white, size: 25.0),
                          ),
                        ),
                        Positioned(
                          top: 45,
                          right: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: IconButton(
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context,
                                        listen: false)
                                    .logout();
                                Navigator.pushNamedAndRemoveUntil(context,
                                    LoginSignUp.routeName, (route) => false);
                              },
                              icon: const Icon(Icons.logout,
                                  color: Colors.red, size: 25.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileStatsCard(
                          color_1: Theme.of(context).primaryColor,
                          color_2: Theme.of(context).colorScheme.secondary,
                          title: "WEEKLY",
                          value_1: state.weekTotalSpent,
                          value_2: state.weeklyBudget,
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        ProfileStatsCard(
                          color_1: Theme.of(context).colorScheme.secondary,
                          color_2: Theme.of(context).primaryColor,
                          title: "MONTHLY",
                          value_1: state.monthTotalSpent,
                          value_2: state.monthlyBudget,
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
                    height: 130,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF6F8FF),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    margin: const EdgeInsets.only(
                        left: 20, top: 15, right: 20, bottom: 15),
                    child: Stack(
                      children: [
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
                              children: [
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  UserRepository.user?.name as String,
                                  style: const TextStyle(
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
                              children: [
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  UserRepository.user?.email as String,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            // const SizedBox(
                            //   height: 14.0,
                            // ),
                            // Row(
                            //   children: const [
                            //     SizedBox(
                            //       width: 20.0,
                            //     ),
                            //     Text(
                            //       'Gender',
                            //       style: TextStyle(
                            //         fontSize: 14.0,
                            //         color: Color(0xFF706F6F),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: const [
                            //     SizedBox(
                            //       width: 20.0,
                            //     ),
                            //     Text(
                            //       'Female',
                            //       style: TextStyle(
                            //         fontSize: 18.0,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text("Unable to load data :("),
            );
          }
        },
      ),
    );
  }

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Color(0xff7286D3),
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
