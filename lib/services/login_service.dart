import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dojo/models/user_model.dart';
import 'package:dojo/services/shared_prefs_service.dart';

class LoginService {
  // final String baseUrl = 'http://localhost:5000/api/users';
  final String baseUrl = 'http://localhost:5000/api/users';

  Future<User?> login(
      String email, String password, BuildContext context) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if ((data != null && data['data'] != null) && data['token'] != null) {
          final userData = data['data'];
          final token = data['token'];

          await saveUserData(userData, token);
          User user = User.fromJson(userData);

          // User user = User.fromJson(userData);
          // await saveUserData(user.id.toString(), user.name, token);

          if (user.organizations != null && user.organizations!.isNotEmpty) {
            await saveUserOrganization(user.organizations!.first.name);
          } else if (user.orgMembers != null && user.orgMembers!.isNotEmpty) {
            await saveUserOrganization(user.orgMembers!.first.name);
          } else {
            await saveUserOrganization('');
          }
          return user;
        }
      } else if (response.statusCode == 401) {
        print('Login failed: Invalid email or password');
      } else {
        print('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return null;
  }
}
