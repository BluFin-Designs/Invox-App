import 'package:flutter/material.dart';

import '../Widgets/Login_button.dart';

class LoginSignUp extends StatelessWidget {
  static const routeName = '/login-signup';

  const LoginSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF7B54),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(
              'assets/images/logo.png',
            ),
            height: 50.0,
          ),
          const SizedBox(
            height: 40.0,
          ),
          const Text(
            'Begin your Journey in\nSaving\nWith just one click!',
            style: TextStyle(color: Colors.white, fontSize: 25.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40.0,
          ),
          const Image(
            image: AssetImage('assets/images/loginPage_Asset.png'),
          ),
          const SizedBox(
            height: 25.0,
          ),
          ReusableCard(
              icon: 'assets/images/google_logo.png',
              text: 'Continue with Google',
              onPress: () {}),
          ReusableCard(
              icon: 'assets/images/email_logo.png',
              text: 'Continue with Email',
              onPress: () {}),
        ],
      ),
    );
  }
}
