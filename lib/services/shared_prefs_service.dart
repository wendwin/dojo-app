import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLoginStatus(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
  print('Login status saved: $isLoggedIn');
}

Future<bool> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('Login status checked');
  return prefs.getBool('isLoggedIn') ?? false;
}

Future<void> logoutUser() async {
  final prefs = await SharedPreferences.getInstance();

  // Hapus semua data pengguna dari SharedPreferences
  await prefs.remove('id');
  await prefs.remove('name');
  await prefs.remove('email');
  await prefs.remove('role');
  await prefs.remove('token');
  await prefs.remove('org_members');
  await prefs.remove('organizations');

  print('Logout successful: User data cleared');
}

Future<void> saveUserData(Map<String, dynamic> userData, String token) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setInt('id', userData['id']);
  await prefs.setString('name', userData['name']);
  await prefs.setString('email', userData['email']);
  await prefs.setString('role', userData['role']);
  await prefs.setString('token', token);

  await prefs.setString(
      'org_members', jsonEncode(userData['org_members'] ?? []));
  await prefs.setString(
      'organizations', jsonEncode(userData['organizations'] ?? []));

  print("User data saved (shared): ${userData.toString()}");
}

Future<Map<String, dynamic>> getUserData() async {
  final prefs = await SharedPreferences.getInstance();

  final int? id = prefs.getInt('id');
  final String? name = prefs.getString('name');
  final String? email = prefs.getString('email');
  final String? role = prefs.getString('role');
  final String? token = prefs.getString('token');

  final String? orgMembersJson = prefs.getString('org_members');
  final String? organizationsJson = prefs.getString('organizations');

  final List<dynamic> orgMembers =
      orgMembersJson != null ? jsonDecode(orgMembersJson) : [];
  final List<dynamic> organizations =
      organizationsJson != null ? jsonDecode(organizationsJson) : [];

  print('Organizations (shared): $organizations');
  print('OrgMembers (shared): $orgMembers');

  return {
    'id': id,
    'name': name,
    'email': email,
    'role': role,
    'token': token,
    'org_members': orgMembers,
    'organizations': organizations,
  };
}

Future<void> saveUserOrganization(String? organizationName) async {
  final prefs = await SharedPreferences.getInstance();
  if (organizationName != null) {
    await prefs.setString('organization', organizationName);
    print('Organization saved (shared): $organizationName');
  }
}

Future<String?> getUserOrganization() async {
  final prefs = await SharedPreferences.getInstance();

  var org = prefs.getString('organization');
  print('Get organization (shared): $org');
  return org;
}
