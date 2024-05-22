import 'dart:io';

import 'package:app_student/api/class_groups/models/class_group_model.dart';
import 'package:app_student/api/users/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../api/users/repositories/user_repository.dart';
import '../../utils/global.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit({required this.userRepository}) : super(UserInitial());

  Future<void> fetchUser() async {
    try {
      emit(UserLoading());
      final user = await userRepository.getUser();

      if (user.className == null || user.className!.isEmpty) {
        emit(UserWithoutClass(user));
      } else if (user.ine != null &&
          user.ine!.isNotEmpty &&
          user.birthDate != null &&
          user.studentId != null) {
        emit(UserLoaded(user));
      } else if (user.ine == null ||
          (user.ine != null && user.ine!.isEmpty) ||
          user.birthDate == null) {
        emit(UserNameLoaded(user));
      }
    } catch (e) {
      if (!isClosed) {
        emit(UserError(e.toString()));
      }
    }
  }

  Future<UserModel> getCurrentUser() async {
    return userRepository.getUser();
  }

  Future<void> saveUserClass(ClassGroupModel classGroup) async {
    await userRepository.saveUserClass(classGroup.name.toString());
    await FirebaseMessaging.instance
        .subscribeToTopic(classGroup.name.toString().replaceAll(' ', ''));
    emit(UserClassesSelected());
  }

  Future<void> deleteUser() async {
    // On se désabonne de tous les topics
    final user = await userRepository.getUser();
    if (user.className != null) {
      await FirebaseMessaging.instance
          .unsubscribeFromTopic(user.className.toString().replaceAll(' ', ''));
    }
    await userRepository.delete();
  }

  Future<void> clearUserClass() async {
    await userRepository.clearClass();
  }

  Future<void> loginAndSaveId(String username, String password) async {
    emit(UserLoading());
    try {
      final studentId = await userRepository.login(username, password);
      Global.setIne(username);
      Global.setBirthDate(password);
      Global.setStudentId(studentId);
      final user = await userRepository.getUser();
      emit(UserLoggedIn(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> fetchMarks() async {
    emit(UserLoading());
    try {
      final user = await userRepository.getUser();
      if (user.studentId != null) {
        final File marks = await userRepository.getMarks(user.studentId!);
        if (kDebugMode) {
          print(marks.path);
        }
        final File absences = await userRepository.getAbsences(user.studentId!);
        if (kDebugMode) {
          print(absences.path);
        }
        emit(UserLoaded(user));
      } else {
        throw Exception('No student ID found in SharedPreferences');
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> checkStudentId() async {
    final user = await getCurrentUser();

    if (user.studentId != null) {
      emit(UserLoggedIn(user));
    } else {
      emit(UserInitial());
    }
  }
}
