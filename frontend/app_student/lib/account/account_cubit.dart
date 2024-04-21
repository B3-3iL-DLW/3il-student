
import 'dart:io';

import 'package:app_student/utils/global.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:app_student/api/account/repositories/account_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountRepository accountRepository;

  AccountCubit({required this.accountRepository}) : super(AccountInitial());

  Future<void> loginAndSaveId(String username, String password) async {
    emit(AccountLoading());
    try {
      final studentId = await accountRepository.login(username, password);
      emit(AccountLoggedIn(studentId: studentId));
    } catch (e) {
      emit(AccountError());
    }
  }

  Future<void> fetchMarks() async {
    emit(AccountLoading());
    try {
      final studentId = await Global.studentId;
      if (studentId != null) {
        final File marks = await accountRepository.getMarks(studentId);
        final File absences = await accountRepository.getAbsences(studentId);
        emit(AccountLoaded(marksFile: marks, absencesFile: absences));
      } else {
        throw Exception('No student ID found in SharedPreferences');
      }
    } catch (e) {
      emit(AccountError());
    }
  }

  Future<void> checkStudentId() async {
    int? id = await Global.studentId;

    if (id != null) {
      emit(AccountLoggedIn(studentId: id));
    } else {
      emit(AccountInitial());
    }
  }


}
