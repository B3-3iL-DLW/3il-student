
import 'package:app_student/api/classes/entities/class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClassRepository {
  final String apiUrl;

  ClassRepository({required this.apiUrl});

  Future<List<Class>> getClasses() async {
    final response = await http.get(Uri.parse('$apiUrl/api/classes'));

    print(response.statusCode);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Class.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load classes');
    }
  }
}
