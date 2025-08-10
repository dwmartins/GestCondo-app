import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/auth/login"),
      headers: {
        "Content-Type": "application/json",
        "X-Api-Key": ApiConfig.apiKey,
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final responseData = json.decode(response.body);
    
    if (response.statusCode == 200) {
      return responseData;
    } else {
      throw responseData['message'] ?? 'Falha no login';
    }
  }
}