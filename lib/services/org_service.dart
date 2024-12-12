import 'dart:convert';
import 'package:dojo/models/org_model.dart';
import 'package:http/http.dart' as http;

class OrganizationService {
  final String baseUrl = 'http://192.168.18.248:5000/api';
  // final String baseUrl = 'http://192.168.100.74:5000/api';

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
      // Tangani error pada jaringan atau lainnya
      print('Terjadi error saat mengambil data organisasi: $e');
      return [];
    }
  }
}
