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
        print('JSON Response: $jsonResponse');

        return jsonResponse.map((item) {
          print('Item: $item'); // Print the item before conversion
          try {
            return fromJson(item);
          } catch (e) {
            print(
                'Failed to convert item: $e'); // Print the error if conversion fails
            throw e;
          }
        }).toList();
      } else {
        throw Exception('ERROR ${response.statusCode} Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
