import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<void> saveToken(String token, String userId) async {
    final url = Uri.parse('$baseUrl/save-token');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': userId,
        'token': token,
      }),
    );

    if (response.statusCode != 200) {
      // Handle errors
      throw Exception('Failed to save token to server');
    }
  }
}

void saveTokenToServer(String? token, String userId) async {
  if (token != null) {
    final apiService = ApiService(
        'https://yourapi.com'); // Replace with your actual API base URL
    try {
      await apiService.saveToken(token, userId);
      print('Token saved successfully');
    } catch (e) {
      print('Error saving token: $e');
    }
  }
}
