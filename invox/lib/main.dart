import 'package:flutter/material.dart';
import "package:hive/hive.dart";
import 'package:hive_flutter/hive_flutter.dart';

import '../Views/Screens/Categories_Screen.dart';
import '../Views/Screens/GoalDetails_Screen.dart';
import '../Views/Screens/LoginSignUp_Screen.dart';
import '../Views/Screens/HomePage_Screen.dart';
import '../Views/Screens/Profile_Screen.dart';
import '../Views/Screens/Transaction_Screen.dart';
import '../Views/Screens/Statistics_Screen.dart';
import '../Views/Screens/MyWallets_Screen.dart';
import '../Views/Screens/Preferences_Screen.dart';
import '../Views/Screens/Budget_Screen.dart';

main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF7B54),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xffFFB26B),
        ),
      ),
      home: const LoginSignUp(),
      routes: {
        LoginSignUp.routeName: (ctx) => const LoginSignUp(),
        HomePage.routeName: (ctx) => const HomePage(),
        Profile.routeName: (ctx) => const Profile(),
        Transaction.routeName: (ctx) => const Transaction(),
        Statistics.routeName: (ctx) => const Statistics(),
        MyWalletsScreen.routeName: (ctx) => MyWalletsScreen(),
        Preferences.routeName: (ctx) => const Preferences(),
        CategoriesPage.routeName: (ctx) => const CategoriesPage(),
        BudgetPage.routeName: (ctx) => const BudgetPage(),
        BudgetDetailsPage.routeName: (ctx) => const BudgetDetailsPage(),
      },
    );
  }
}
