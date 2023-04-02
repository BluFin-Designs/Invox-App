import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCubit() : super(AuthInitial()) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      emit(LoggedInState(currentUser));
    } else {
      emit(LoggedOutState());
    }
  }

  Future signInWithGoogle() async {
    //Emitting Loading State
    emit(LoadingState());

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
  }
}
