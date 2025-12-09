import 'dart:convert';

import 'package:http/http.dart' as http;

/// A utility class for making HTTP requests.
///
/// This class provides static methods for making GET, POST, PUT, and DELETE requests.
/// It also includes a helper method to handle the API response.
class MagicHttpHelper {
  static const String _baseUrl =
      'https://your-api-base-url.com'; // Replace with your API base URL

  /// Sends a GET request to the specified [endpoint].
  ///
  /// Returns a `Future` that completes with a map of the JSON response.
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  /// Sends a POST request to the specified [endpoint] with the given [data].
  ///
  /// Returns a `Future` that completes with a map of the JSON response.
  static Future<Map<String, dynamic>> post(
    String endpoint,
    dynamic data,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  /// Sends a PUT request to the specified [endpoint] with the given [data].
  ///
  /// Returns a `Future` that completes with a map of the JSON response.
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  /// Sends a DELETE request to the specified [endpoint].
  ///
  /// Returns a `Future` that completes with a map of the JSON response.
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  /// Handles the HTTP response.
  ///
  /// If the status code is 200, it decodes the JSON response and returns it as a map.
  /// Otherwise, it throws an exception.
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
