import 'dart:convert';
import 'dart:io';
import 'package:app_student/api/users/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_service.dart';
import '../../documents/entities/document_entity.dart';
import '../entities/user_entity.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  Future<void> createUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }

  Future<UserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);

      return UserModel.fromJson(userMap);
    } else {
      throw Exception('No user found in cache');
    }
  }

  Future<void> delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  Future<void> clearClass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('className');
  }

  Future<UserModel> login(String ine, String birthDate) async {
    final response = await http.post(
      Uri.parse('${apiService.apiUrl}/api/student/login'),
      body: {'username': ine, 'password': birthDate},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final studentId = (data['studentId']);

      List<DocumentEntity> documents = [];
      if (studentId != null) {
        documents = await downloadStudentFiles(studentId);
      }

      // Get the current user from the cache
      UserModel user;
      try {
        user = await getUser();
      } catch (e) {
        user = UserModel(entity: UserEntity());
      }

      // Update the user data
      user.entity.firstName = user.entity.firstName;
      user.entity.ine = ine;
      DateFormat format = DateFormat('dd/MM/yyyy');
      user.entity.birthDate = format.parse(birthDate);
      user.entity.className = user.entity.className;
      user.entity.studentId = studentId ?? '';
      user.entity.documents = documents;

      await createUser(user);

      return user;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<File> downloadFile(String url, String filename) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$filename');

      await file.writeAsBytes(response.bodyBytes);

      return file;
    } else {
      throw Exception('Failed to download file');
    }
  }

  Future<List<DocumentEntity>> downloadStudentFiles(int studentId) async {
    final marksFile = await downloadFile(
        '${apiService.apiUrl}/api/student/marks/$studentId', 'notes.pdf');
    final absencesFile = await downloadFile(
        '${apiService.apiUrl}/api/student/absences/$studentId', 'absences.pdf');

    final marksDocument =
        DocumentEntity(title: 'Relevé de notes', file: marksFile);
    final absencesDocument =
        DocumentEntity(title: "Relevé d'absences", file: absencesFile);

    return [marksDocument, absencesDocument];
  }
}
