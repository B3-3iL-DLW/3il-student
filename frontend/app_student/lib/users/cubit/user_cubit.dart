
import 'package:app_student/api/class_groups/models/class_group_model.dart';
import 'package:app_student/api/users/models/user_model.dart';
import 'package:bloc/bloc.dart';
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
      print('fetchUser');
      final user = await userRepository.getUser();
      print('fetchUser completed');

      // print all user data to console
      print(user.toString());

      //user avec className et firstname uniquement et tout le reste vide ou null
      if (user.firstName != null && user.className != null) {
        emit(UserWihtoutLink(user));
      } else if (user.className == null || user.className!.isEmpty) {
        emit(UserWithoutClass(user));
      } else if (user.ine != null &&
          user.ine!.isNotEmpty &&
          user.birthDate != null &&
          user.studentId != null) {
        emit(UserLoggedIn(user));
      }
    } catch (e) {
      print('fetchUser failed: $e');
      if (!isClosed) {
        emit(UserError(e.toString()));
      }
    }
  }

  Future<UserModel> getCurrentUser() async {
    return userRepository.getUser();
  }

  Future<void> saveUserClass(ClassGroupModel classGroup) async {
    UserModel user = await userRepository.getUser();
    user.entity.className = classGroup.name;

    await userRepository.saveUserDetails(user);

    emit(UserClassesSelected());
  }

  Future<void> deleteUser() async {
    await userRepository.delete();
  }

  Future<void> clearUserClass() async {
    await userRepository.clearClass();
  }

  Future<void> loginAndSaveId(String username, String password) async {
    emit(UserLoading());
    print('loginAndSaveId started');
    try {
      final user = await userRepository.login(username, password);
      print('loginAndSaveId completed');
      await Global.setUser(user);

      emit(UserLoggedIn(user));
    } catch (e) {
      print('loginAndSaveId failed: $e');
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
