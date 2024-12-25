import 'dart:convert';
import 'package:dojo/models/org_model.dart';
import 'package:http/http.dart' as http;

class OrganizationService {
  final String baseUrl = 'http://localhost:5000/api';

  Future<List<Organization>?> fetchOrganizations() async {
    final url = Uri.parse('$baseUrl/organizations');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);

          if (responseData.containsKey('data') &&
              responseData['data'] is List) {
            final List<dynamic> data = responseData['data'];
            return data.map((org) => Organization.fromJson(org)).toList();
          } else {
            print('Key "data" tidak ditemukan atau bukan daftar');
            return [];
          }
        } else {
          print('Response body kosong');
          return [];
        }
      } else {
        print('Gagal mengambil organisasi: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Terjadi error saat mengambil data organisasi: $e');
      return [];
    }
  }
}

class OrganizationJoinService {
  final String baseUrl = 'http://localhost:5000/api';

  Future<bool> joinOrganization(int userId, String enrollCode) async {
    final url = Uri.parse('$baseUrl/join-organization');
    final body = {
      "user_id": userId,
      "enroll_code": enrollCode,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body);

      if (responseData['message'] == 'Successfully joined the organization.') {
        return true;
      } else {
        // Log kesalahan
        print('Error: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/api/users/$userId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load user data');
    }
  }
}

class CreateOrganizationService {
  final String baseUrl = 'http://localhost:5000/api';
  Future<bool> createOrganization(
      String name, String enrollCode, int userId) async {
    final url = Uri.parse('$baseUrl/organizations');
    final body = {
      "name": name,
      "enroll_code": enrollCode,
      "user_id": userId,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final responseData = jsonDecode(response.body);

      if (responseData['message'] == 'Organization created successfully') {
        return true; // Berhasil enroll
      } else {
        // Log kesalahan
        print('Error: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/api/users/$userId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
