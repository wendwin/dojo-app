import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  final String baseUrl = 'http://127.0.0.1:5000/api/users';
  // final String baseUrl = 'http://192.168.100.74:5000/api/users';

  Future<bool> registerUser(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/register'); // Ubah endpoint sesuai API-mu

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
