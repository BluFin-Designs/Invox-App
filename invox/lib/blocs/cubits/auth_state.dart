part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {}

class LoggedInState extends AuthState {
  final User fireBaseUser;
  LoggedInState(this.fireBaseUser);
}

class LoggedOutState extends AuthState {}

class LoggedInErrorState extends AuthState {
  final String error;
  LoggedInErrorState(this.error);
}
