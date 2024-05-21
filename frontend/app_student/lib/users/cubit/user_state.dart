part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;

  UserLoaded(this.user);
}

class UserNameLoaded extends UserState {
  final UserModel user;

  UserNameLoaded(this.user);
}

class UserClassesSelected extends UserState {}

class UserWithoutClass extends UserState {
  final UserModel user;

  UserWithoutClass(this.user);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

class UserLoggedIn extends UserState {
  final UserModel user;

  UserLoggedIn(this.user);
}

class UserMarksLoaded extends UserState {
  final UserModel user;
  final File marks;

  UserMarksLoaded(this.user, this.marks);
}

class UserAbsencesLoaded extends UserState {
  final UserModel user;
  final File absences;

  UserAbsencesLoaded(this.user, this.absences);
}
