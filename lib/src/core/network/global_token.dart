import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<void> saveFcmToken(String fcmToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcmToken', fcmToken);
  }

  static Future<String?> getFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcmToken');
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<void> saveName(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  // static Future<void> saveEmail(String email) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('email', email);
  // }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  // static Future<String?> getEmail() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('email');
  // }

  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

  static Future<void> getRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }
}
