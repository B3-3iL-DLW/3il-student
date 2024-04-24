import 'package:app_student/api/users/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entities/user_entity.dart';

class UserRepository {
  Future<UserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString('name');
    String? className = prefs.getString('className');
    String? ine = prefs.getString('ine');
    String? birthDate = prefs.getString('birthDate');

    if (name == null) {
      throw Exception('User name not found');
    }

    print('UserRepository.getUser: name: $name, className: $className, ine: $ine, birthDate: $birthDate');
    return UserModel(
      entity: UserEntity(
        firstName: name,
        className: className,
        ine: ine,
        birthDate: birthDate != null ? DateTime.parse(birthDate) : null,
      ),
    );
  }

  Future<void> saveUserDetails(String name, String? className,
      {String? ine, String? birthDate}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel(
      entity: UserEntity(
        firstName: name,
        className: className,
        ine: ine,
        birthDate: birthDate != null ? DateTime.parse(birthDate) : null,
      ),
    );
    await prefs.setString('name', name);
    if (className != null) {
      await prefs.setString('className', className);
    }
    if (ine != null) {
      await prefs.setString('ine', ine);
    }
    if (birthDate != null) {
      await prefs.setString('birthDate', birthDate);
    }
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
