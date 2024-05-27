import 'package:app_student/api/users/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../api/users/entities/user_entity.dart';
import '../../api/users/models/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository userRepository;

  LoginCubit({required this.userRepository}) : super(LoginInitial()) {
    checkUserAuthentication();
  }

  Future<bool> areFieldsFilled(String name) async {
    if (name.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> saveLoginDetails(String name) async {
    if (!(await areFieldsFilled(name))) {
      emit(LoginFieldError());
      return;
    }

    UserModel user = UserModel(
      entity: UserEntity(
        firstName: name,
        className: null,
        ine: null,
        birthDate: null,
        studentId: null,
        documents: null,
      ),
    );

    await userRepository.saveUserDetails(user);
    emit(RedirectToClassSelection());
  }

  Future<bool> checkUserAuthentication() async {
    try {
      var user = await userRepository.getUser();
      if (user.hasClassName == false || user.isEmpty) {
        emit(LoginInitial());
        return false;
      }
      emit(LoginAuthenticated());
      return true;
    } catch (e) {
      emit(LoginInitial());
      return false;
    }
  }

  Future<void> logout() async {
    emit(LoginInitial());
  }
}
