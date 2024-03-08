import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl;

  ApiService({required this.apiUrl});

  Future<List<T>> getData<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(Uri.parse('$apiUrl$endpoint'));
    print('$apiUrl$endpoint');
    print('response.statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => fromJson(item)).toList();
    } else {
      print('response.body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }
}