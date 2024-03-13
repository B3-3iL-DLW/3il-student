import 'package:app_student/api/users/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository userRepository;

  LoginCubit(this.userRepository) : super(LoginInitial()) {
    checkUserAuthentication();
  }

  Future<bool> areFieldsFilled(
      String ine, String name, String birthDate) async {
    if (ine.isEmpty || name.isEmpty || birthDate.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> saveLoginDetails(
      String ine, String name, String birthDate) async {
    if (!(await areFieldsFilled(ine, name, birthDate))) {
      emit(LoginFieldError());
      return;
    }
    await userRepository.saveUserDetails(ine, name, birthDate, '');
    emit(RedirectToClassSelection());
  }

  Future<void> checkUserAuthentication() async {
    try {
      await userRepository.getUser();
      emit(LoginAuthenticated());
    } catch (e) {
      emit(LoginFieldError());
    }
    emit(LoginInitial());
  }
}
