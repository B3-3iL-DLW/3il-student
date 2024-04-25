part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;

  UserLoaded(this.user);
}

class UserPartialLoaded extends UserState {
  final UserModel user;

  UserPartialLoaded(this.user);
}

class UserClassesSelected extends UserState {}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
