import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class AuthService {
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password
        })
      );

      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Login bem-sucedido: $data");
        return true;
      } else {
        print("Erro no login: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Erro na requisição $e");
      return false;
    }
  }
}