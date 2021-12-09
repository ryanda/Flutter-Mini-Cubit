part of 'user_cubit.dart';

@immutable
abstract class UserState extends Equatable {
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserFetched extends UserState {
  final User profile;

  UserFetched({required this.profile});

  List<Object> get props => [profile];
}
