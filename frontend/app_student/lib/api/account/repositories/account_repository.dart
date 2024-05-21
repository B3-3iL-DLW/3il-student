import 'dart:io';
import 'package:app_student/api/api_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../utils/global.dart';

class AccountRepository {
  final ApiService apiService;

  AccountRepository({required this.apiService});

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
