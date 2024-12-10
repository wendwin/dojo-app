import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserData(String userId, String userName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
  await prefs.setString('userName', userName);
  print("User data saved: userId=$userId, userName=$userName");
}

Future<void> saveUserOrganization(String? organizationName) async {
  final prefs = await SharedPreferences.getInstance();
  if (organizationName != null) {
    await prefs.setString('organization', organizationName);
  }
}

Future<String?> getUserOrganization() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('organization');
}

Future<void> logoutUser() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userId');
  await prefs.remove('userName');
  print("User data cleared: userId and userName have been removed.");
}

Future<Map<String, String>> getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('userId') ?? '';
  final userName = prefs.getString('userName') ?? '';
  return {'userId': userId, 'userName': userName};
}

Future<void> clearUserData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_name');
  print("User data cleared");
}
