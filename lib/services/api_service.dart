import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://6a00a53836fb6ad04de056ae.mockapi.io/api/v1';

  Future<dynamic> get(String endpoint) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$endpoint'))
        .timeout(const Duration(seconds: 10));

    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/$endpoint'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 10));

    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final response = await http
        .put(
          Uri.parse('$baseUrl/$endpoint'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 10));

    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await http
        .delete(Uri.parse('$baseUrl/$endpoint'))
        .timeout(const Duration(seconds: 10));

    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('API Error ${response.statusCode}: ${response.body}');
    }
  }
}
