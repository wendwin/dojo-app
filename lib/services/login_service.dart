import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dojo/models/user_model.dart';
import 'package:dojo/services/shared_prefs_service.dart';

class Loginservice {
  final String baseUrl = 'http://127.0.0.1:5000/api/users';
  // final String baseUrl = 'http://192.168.100.74:5000/api/users';

  Future<User?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        User user = User.fromJson(data);
        await saveUserData(user.name);
        return user;
      } else if (response.statusCode == 401) {
        print('Login failed: Invalid email or password');
        return null;
      } else {
        print('Login failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }
}
