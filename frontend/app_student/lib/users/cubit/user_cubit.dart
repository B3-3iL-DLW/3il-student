import 'package:app_student/api/class_groups/models/class_group_model.dart';
import 'package:app_student/api/users/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../api/users/repositories/user_repository.dart';
import '../../login/cubit/login_cubit.dart';
import '../../utils/global.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  final LoginCubit loginCubit;

  UserCubit({required this.userRepository, required this.loginCubit})
      : super(UserInitial());

  Future<void> fetchUser() async {
    try {
      emit(UserLoading());
      print('fetchUser');
      final user = await userRepository.getUser();
      print('fetchUser completed');

      // print all user data to console
      print(user.toString());

      if (user.isEmpty) {
        print(user.toString());
        emit(UserInitial());
      } else if (user.hasFirstName) {
        if (user.hasClassName == false) {
          emit(UserWithoutClass(user));
        } else if (user.hasIne && user.hasBirthDate && user.hasStudentId) {
          emit(UserLoggedIn(user));
        } else {
          emit(UserWihtoutLink(user));
        }
      }
    } catch (e) {
      print('fetchUser failed: $e');
      if (!isClosed) {
        if (e.toString() == 'Exception: No user found in cache') {
          emit(UserInitial());
        } else {
          emit(UserError(e.toString()));
        }
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

    emit(UserWihtoutLink(user));
  }

  Future<void> deleteUser() async {
    await userRepository.delete();
  }

  Future<void> logout() async {
    await deleteUser();
    await loginCubit.logout();
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
