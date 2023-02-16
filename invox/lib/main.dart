import 'package:flutter/material.dart';

import './Views/Screens/LoginSignUp_Screen.dart';
import './Views/Screens/HomePage_Screen.dart';

void main() {
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
        accentColor: const Color(0xffFFB26B),
      ),
      home: const LoginSignUp(),
      routes: {
        LoginSignUp.routeName: (ctx) => const LoginSignUp(),
        HomePage.routeName: (ctx) => const HomePage(),
      },
    );
  }
}
