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
          classGroup: null,
        ),
      );
    } else {
      throw Exception('Utilisateur non trouvé');
    }
  }

  Future<void> saveUserDetails(
      String ine, String name, String birthDate, String className) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ine', ine);
    await prefs.setString('name', name);
    await prefs.setString('birthDate', birthDate);
    await prefs.setString('className', className);
  }
}
