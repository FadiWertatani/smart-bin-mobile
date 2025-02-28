import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  // Save email to SharedPreferences
  static Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  // Retrieve email from SharedPreferences
  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  // Clear email from SharedPreferences (optional)
  static Future<void> clearEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }
}
