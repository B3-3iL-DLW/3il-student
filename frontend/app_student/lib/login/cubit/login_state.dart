part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginAuthenticated extends LoginState {}

class LoginFieldError extends LoginState {}

class RedirectToClassSelection extends LoginState {}
