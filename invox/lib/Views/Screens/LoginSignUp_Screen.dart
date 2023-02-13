import 'package:flutter/material.dart';

class LoginSignUp extends StatelessWidget {
  static const routeName = '/product-detail';

  const LoginSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page!"),
      ),
      body: const Center(
        child: Text("Design LogIn Screen!"),
      ),
    );
  }
}
