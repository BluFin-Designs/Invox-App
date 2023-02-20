import 'package:flutter/material.dart';
import '../Views/Screens/LoginSignUp_Screen.dart';
import '../Views/Screens/Profile_Screen.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const Profile(),
      routes: {
        LoginSignUp.routeName: (ctx) => const LoginSignUp(),
        Profile.routeName: (ctx) => const Profile(),
      },
    );
  }
}
