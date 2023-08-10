import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCubit() : super(AuthInitial()) {
    User? currentUser = _auth.currentUser;
    // getGender();
    if (currentUser != null) {
      emit(LoggedInState(currentUser));
    } else {
      emit(LoggedOutState());
    }
  }

  logout() async {
    emit(AuthInitial());
    await _signOut();
    emit(LoggedOutState());
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', "https://www.googleapis.com/auth/userinfo.profile"]);

  // get gender
  // Future<String> getGender() async {
  //   await googleSignIn.signIn();
  //   var url = Uri.https(
  //       'people.googleapis.com', 'v1/people/me?personFields=genders&key=');
  //
  //   final headers = await googleSignIn.currentUser?.authHeaders;
  //   final r = await http.get(url,
  //       headers: {"Authorization": headers!["Authorization"] as String});
  //   final response = jsonDecode(r.body);
  //
  //   debugPrint(response.toString());
  //   debugPrint(response["genders"][0]["formattedValue"]);
  //
  //   return response["genders"][0]["formattedValue"];
  // }

  Future signInWithGoogle() async {
    //Emitting Loading State
    emit(LoadingState());

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      try {
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          emit(LoggedInState(userCredential.user!));
        }
      } on FirebaseAuthException catch (e) {
        emit(LoggedInErrorState(e.message.toString()));
      }
    } catch (ex) {
      emit(LoggedInErrorState(ex.toString()));
    }
  }
}
