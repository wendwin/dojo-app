import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  final String baseUrl = 'http://localhost:5000/api/users';

  Future<bool> registerUser(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        print('User registered successfully');
        return true;
      } else {
        print('Failed to register user: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }
}
