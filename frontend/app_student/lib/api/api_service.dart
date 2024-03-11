import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl;

  ApiService({required this.apiUrl});

  Future<List<T>> getData<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    String fullUrl = '$apiUrl$endpoint';
    fullUrl = Uri.encodeFull(fullUrl);
    print(fullUrl);
    try {
      final response = await http.get(Uri.parse(fullUrl));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        print('JSON Response: $jsonResponse'); // Print the JSON response
        return jsonResponse.map((item) => fromJson(item)).toList();
      } else {
        throw Exception('ERROR ${response.statusCode} Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

// Future<List<T>> getData<T>(
//     String endpoint, T Function(Map<String, dynamic>) fromJson) async {
//   String fullUrl = '$apiUrl$endpoint';
//   fullUrl = Uri.encodeFull(fullUrl);
//   print(fullUrl);
//   try {
//     final response = await http.get(Uri.parse(fullUrl));
//
//     if (response.statusCode == 200) {
//       var jsonResponse = json.decode(response.body);
//       print('JSON Response: $jsonResponse'); // Print the JSON response
//
//       // Check if jsonResponse is a Map. If so, convert it to a List
//       if (jsonResponse is Map<String, dynamic>) {
//         jsonResponse = [jsonResponse];
//       }
//
//       return jsonResponse.map((item) => fromJson(item)).toList();
//     } else {
//       print('ERROR ${response.statusCode} Failed to load data');
//       throw Exception('ERROR ${response.statusCode} Failed to load data');
//     }
//   } catch (e) {
//     print('Failed to load data: $e');
//     throw Exception('Failed to load data: $e');
//   }
// }
}
