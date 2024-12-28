import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PresenceService {
  // final String baseUrl = 'http://localhost:5000/api/presences';
  final String baseUrl = 'http://192.168.100.243:5000/api/add-presences';

  Future<Map<String, dynamic>?> createPresence({
    required int userId,
    required int orgId,
    required String status,
    required String date,
    required String timeOpen,
    required String timeClose,
    required BuildContext context,
  }) async {
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'org_id': orgId,
          'date': date,
          'status': date,
          'time_open': timeOpen,
          'time_close': timeClose,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        _showError(context, 'Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      _showError(context, 'Error: $e');
      return null;
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
