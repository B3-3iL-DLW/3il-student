import 'package:app_student/api/users/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entities/user_entity.dart';

class UserRepository {
  Future<UserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? ine = prefs.getString('ine');
    String? name = prefs.getString('name');
    String? birthDate = prefs.getString('birthDate');
    String? className = prefs.getString('className');
    if (ine != null && name != null && birthDate != null) {
      return UserModel(
        entity: UserEntity(
          ine: ine,
          firstName: name,
          birthDate: DateTime.parse(birthDate),
          className: className,
        ),
      );
    } else {
      throw Exception('Utilisateur non trouvé');
    }
  }

  Future<void> saveUserDetails(
      String ine, String name, String birthDate, String className) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel(
      entity: UserEntity(
        ine: ine,
        firstName: name,
        birthDate: DateTime.parse(birthDate),
        className: className,
      ),
    );
    await prefs.setString('ine', ine);
    await prefs.setString('name', name);
    await prefs.setString('birthDate', birthDate);
    await prefs.setString('className', className);
  }

  Future<void> deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('ine');
    await prefs.remove('name');
    await prefs.remove('birthDate');
    await prefs.remove('className');
  }

  Future<void> saveUserClass(String className) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('className', className);
  }

  Future<void> delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('ine');
    await prefs.remove('name');
    await prefs.remove('birthDate');
    await prefs.remove('className');
    await prefs.remove('studentId');
  }

  Future<void> clearClass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('className');
  }
}
