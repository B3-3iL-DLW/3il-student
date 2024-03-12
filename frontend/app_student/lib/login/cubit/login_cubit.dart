import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ine', ine);
    await prefs.setString('name', name);
    await prefs.setString('birthDate', birthDate);
    emit(RedirectToClassSelection());
  }

  Future<void> checkUserAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ine = prefs.getString('ine');
    String? name = prefs.getString('name');
    String? birthDate = prefs.getString('birthDate');
    String? className = prefs.getString('className');

    if (ine != null && name != null && birthDate != null && className != null) {
      emit(LoginAuthenticated());
    } else {
      emit(LoginInitial());
    }
  }
}
