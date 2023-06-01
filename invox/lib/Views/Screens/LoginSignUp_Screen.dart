import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invox/blocs/cubits/auth_cubit.dart';

import '../Widgets/Login_button.dart';
import '../Screens/HomePage_Screen.dart';

class LoginSignUp extends StatelessWidget {
  static const routeName = '/login-signup';

  const LoginSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LoggedInState) {
                Navigator.pushReplacementNamed(context, HomePage.routeName);
              }
              if (state is LoggedInErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LoadingState) {
                return Stack(
                  children: [
                    ReusableCard(
                      icon: 'assets/images/google_logo.png',
                      text: 'Continue with Google',
                      onPress: () {},
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                );
              }
              return ReusableCard(
                  icon: 'assets/images/google_logo.png',
                  text: 'Continue with Google',
                  onPress: () {
                    BlocProvider.of<AuthCubit>(context).signInWithGoogle();
                  });
            },
          ),
          ReusableCard(
              icon: 'assets/images/email_logo.png',
              text: 'Continue with Email',
              onPress: () {}),
        ],
      ),
    );
  }
}
