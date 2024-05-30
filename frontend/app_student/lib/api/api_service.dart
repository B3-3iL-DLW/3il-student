import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl;

  ApiService({required this.apiUrl});

  Future<List<T>> getData<T>(
      String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    String fullUrl = '$apiUrl$endpoint';
    fullUrl = Uri.encodeFull(fullUrl);
    try {
      final response = await http
          .get(Uri.parse(fullUrl))
          .timeout(const Duration(seconds: 20), onTimeout: () {
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
        throw const HttpException('HttpException');
      }
    } on TimeoutException catch (_) {
      throw TimeoutException('too_many_requests');
    } on SocketException catch (_) {
      throw const SocketException('noConnected');
    }on ArgumentError catch (_) {
      throw ArgumentError('invalid_url');
    } on HttpException catch (_) {
      throw const HttpException('HttpException');
    }  on FormatException catch (_) {
      throw const FormatException('invalid');
    }catch (e) {
      throw Exception('other');
    }
  }
}
