import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data; // biasanya data token atau user
    } else {
      throw Exception(data['message'] ?? 'Login gagal');
    }
  }
}
