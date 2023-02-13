import 'package:flutter/material.dart';
import 'package:invox/Views/Widgets/Login_button.dart';

class LoginSignUp extends StatelessWidget {
  static const routeName = '/product-detail';

  const LoginSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF7B54),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(
              'images/Asset 3@4x 1.png',
            ),
            height: 50.0,
          ),
          SizedBox(
            height: 40.0,
          ),
          Text(
            'Begin your Journey in\nSaving\nWith just one click!',
            style: TextStyle(color: Colors.white, fontSize: 25.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40.0,
          ),
          Image(
            image: AssetImage('images/pngwing 1.png'),
          ),
          SizedBox(
            height: 25.0,
          ),
          ReusableCard(
              icon: 'images/ion_logo-google.png',
              text: 'Continue with Google',
              onPress: () {}),
          ReusableCard(
              icon: 'images/clarity_email-solid.png',
              text: 'Continue with Email',
              onPress: () {}),
        ],
      ),
    );
  }
}
