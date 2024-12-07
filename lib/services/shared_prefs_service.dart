import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserData(String name) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_name', name);
  print("User name saved: $name");
}

Future<String?> getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_name'); // Ambil nama user
}

Future<void> clearUserData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_name');
  print("User data cleared");
}
