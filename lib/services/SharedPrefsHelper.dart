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

  // Save user code to SharedPreferences
  static Future<void> saveUserCode(String userCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_code', userCode);
  }

  // Retrieve user code from SharedPreferences
  static Future<String?> getUserCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_code');
  }

  // Save user code to SharedPreferences
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Retrieve user code from SharedPreferences
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Clear all user data from SharedPreferences
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('user_code');
    await prefs.remove('token');
  }

  static Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('user_code');
    await prefs.remove('token');
  }

  // Save user code to SharedPreferences
  static Future<void> saveOnBoarding(bool onBoarding) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('on_boarding', onBoarding);
  }

  // Retrieve user code from SharedPreferences
  static Future<String?> getOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('on_boarding');
  }

  // Retrieve user code from SharedPreferences
  static Future<String?> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language');
  }

}
