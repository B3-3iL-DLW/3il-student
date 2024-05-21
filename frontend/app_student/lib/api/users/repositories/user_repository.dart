import 'dart:convert';
import 'dart:io';
import 'package:app_student/api/users/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/global.dart';
import '../../api_service.dart';
import '../entities/user_entity.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  Future<UserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString('name');
    String? className = prefs.getString('className');
    String? ine = prefs.getString('ine');
    String? birthDate = prefs.getString('birthDate');
    int? studentId = prefs.getInt('studentId');

    File marksFile = File('');
    File absencesFile = File('');

    if (studentId != null) {
      marksFile = await getMarks(studentId);
      absencesFile = await getAbsences(studentId);
    }

    if (name == null) {
      throw Exception('User name not found');
    }

    DateTime bd = DateTime.now();
    if (birthDate != null) {
      bd = DateFormat('dd/MM/yyyy').parse(birthDate);
    }

    return UserModel(
      entity: UserEntity(
          firstName: name,
          className: className,
          ine: ine,
          birthDate: bd,
          studentId: studentId,
          marksFile: marksFile,
          absencesFile: absencesFile),
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

  Future<int> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${apiService.apiUrl}/api/student/login'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final studentId = (data['studentId']);
      Global.setStudentId(studentId);
      return studentId;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<File> getMarks(int studentId) async {
    final response = await http.get(
      Uri.parse('${apiService.apiUrl}/api/student/marks/$studentId'),
    );

    if (response.statusCode == 200) {
      return _savePdfFile(response.bodyBytes, 'marks.pdf');
    } else {
      throw Exception('Failed to get marks');
    }
  }

  Future<File> getAbsences(int studentId) async {
    final response = await http.get(
      Uri.parse('${apiService.apiUrl}/api/student/absences/$studentId'),
    );

    if (response.statusCode == 200) {
      return _savePdfFile(response.bodyBytes, 'absences.pdf');
    } else {
      throw Exception('Failed to get absences');
    }
  }

  Future<File> _savePdfFile(List<int> bytes, String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/$filename');

    // Écrire les bytes de la réponse dans le fichier
    await file.writeAsBytes(bytes);

    return file;
  }
}
