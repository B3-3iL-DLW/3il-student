part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountError extends AccountState {}

class AccountLoggedIn extends AccountState {
  final int studentId;

  AccountLoggedIn({required this.studentId});
}

class AccountLoaded extends AccountState {
  final File marksFile;
  final File absencesFile;

  AccountLoaded({required this.absencesFile, required this.marksFile});
}
