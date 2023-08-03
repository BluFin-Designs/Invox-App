part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitialState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoadingErrorState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoadedState extends ProfileState {
  UserModel userInfo;
  double monthlyBudget;
  double weeklyBudget;
  double weekTotalSpent;
  double monthTotalSpent;

  ProfileLoadedState({
    required this.userInfo,
    required this.monthlyBudget,
    required this.weeklyBudget,
    required this.monthTotalSpent,
    required this.weekTotalSpent,
  });

  @override
  List<Object> get props => [];
}
