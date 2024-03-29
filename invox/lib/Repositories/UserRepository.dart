import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? name;
  String? uid;
  String? profileImg;
  String? email;
  String? gender;

  UserModel({
    this.name,
    this.uid,
    this.email,
    this.profileImg,
    this.gender,
  });
}

class UserRepository {
  static UserModel? user;
  UserRepository() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;

    user = UserModel(
      name: currentUser?.displayName,
      uid: currentUser?.uid,
      profileImg: currentUser?.photoURL,
      email: currentUser?.email,
    );
  }
}
