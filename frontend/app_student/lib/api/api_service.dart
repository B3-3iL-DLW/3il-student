import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl;

  ApiService({required this.apiUrl});

  Future<List<T>> getData<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    String fullUrl = '$apiUrl$endpoint';
    fullUrl = Uri.encodeFull(fullUrl);
    try {
      final response = await http.get(Uri.parse(fullUrl)).timeout(const Duration(seconds: 20), onTimeout: () {
        throw TimeoutException('The connection has timed out!');
      });

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) {
          try {
            return fromJson(item);
          } catch (e) {
            rethrow;
          }
        }).toList();
      } else {
        throw Exception('ERROR ${response.statusCode} Failed to load data');
      }
    } on TimeoutException catch (e) {
      throw Exception('Request time out: $e');
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}