import 'dart:convert';
import 'package:dojo/models/org_model.dart';
import 'package:http/http.dart' as http;

class OrganizationService {
  final String baseUrl = 'http://127.0.0.1:5000/api';
  // final String baseUrl = 'http://192.168.100.74:5000/api';

  Future<List<Organization>?> fetchOrganizations() async {
    final url = Uri.parse('$baseUrl/organizations');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);

          // Pastikan key 'data' ada
          if (responseData.containsKey('data') &&
              responseData['data'] != null) {
            final List<dynamic> data = responseData['data'];
            return data.map((org) => Organization.fromJson(org)).toList();
          } else {
            print('Key "data" tidak ditemukan atau isinya null');
            return null;
          }
        } else {
          print('Response body kosong');
          return null;
        }
      } else {
        print('Gagal mengambil organisasi: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error disini: $e');
      return null;
    }
  }
}
