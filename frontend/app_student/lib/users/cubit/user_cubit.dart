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

  Future<UserModel> getConnectedUser() async {
    return userRepository.getUser();
  }

  Future<void> saveUserClass(String className) async {
    await userRepository.saveUserClass(className);
  }
}
