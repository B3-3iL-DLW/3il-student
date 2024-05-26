import 'dart:convert';
import 'dart:io';
import 'package:app_student/api/users/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_service.dart';
import '../../documents/entities/document_entity.dart';
import '../entities/user_entity.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  Future<void> saveUserDetails(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
    print('User saved in cache');
    print(userJson);

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

  Future<UserModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${apiService.apiUrl}/api/student/login'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final studentId = (data['studentId']);

      File? marksFile;
      File? absencesFile;

      print('studentId');
      print(studentId);
      if (studentId != null) {
        marksFile = await downloadFile(
            'https://api-dev.lukasvalois.com/api/student/marks/$studentId',
            'marks.pdf');
        print(marksFile);
        absencesFile = await downloadFile(
            'https://api-dev.lukasvalois.com/api/student/absences/$studentId',
            'absences.pdf');
      }

      final marksDocument = DocumentEntity(title: 'Marks', file: marksFile!);
      print(marksDocument);
      final absencesDocument =
      DocumentEntity(title: 'Absences', file: absencesFile!);

      // Get the current user from the cache
      UserModel user;
      try {
        user = await getUser();
      } catch (e) {
        user = UserModel(entity: UserEntity());
      }

      // Update the user data
      user.entity.firstName = data['firstName'];
      user.entity.ine = data['ine'];
      user.entity.birthDate = data['birthDate'] != null
          ? DateTime.parse(data['birthDate'])
          : null;
      user.entity.className = data['className'] ?? '';
      user.entity.studentId = studentId ?? '';
      user.entity.documents = [marksDocument, absencesDocument];

      // Save the user details in the cache
      await saveUserDetails(user);

      return user;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<File> downloadFile(String url, String filename) async {
    print('URL: $url');
    print('Filename: $filename');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Response body bytes: ${response.bodyBytes}');
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$filename');

      await file.writeAsBytes(response.bodyBytes);

      return file;
    } else {
      throw Exception('Failed to download file');
    }
  }
}
