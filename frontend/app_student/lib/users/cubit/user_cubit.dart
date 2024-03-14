import 'package:app_student/api/class_groups/models/class_group_model.dart';
import 'package:app_student/api/users/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/users/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit({required this.userRepository}) : super(UserInitial());

  Future<void> fetchUser() async {
    try {
      emit(UserLoading());
      final user = await userRepository.getUser();
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<UserModel> getCurrentUser() async {
    return userRepository.getUser();
  }

  Future<void> saveUserClass(ClassGroupModel classGroup) async {
    await userRepository.saveUserClass(classGroup.name.toString());
    emit(UserClassesSelected());
  }

}
