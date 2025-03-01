import 'package:dio/dio.dart';
import 'package:smar_bin/services/SharedPrefsHelper.dart';
import 'package:uuid/uuid.dart';

class ApiService {
  // Private constructor
  ApiService._internal();

  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Factory constructor returns the same instance
  factory ApiService() => _instance;

  final Uuid _uuid = Uuid();


  // Dio instance
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.19:5000', // Replace with your actual IP
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  Future<String> registerUser(String name, String email, String password, String clinic) async {
    try {
      // Generate unique random code
      String userCode = _uuid.v4();

      Response response = await _dio.post('/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'clinic': clinic,
        'user_code': userCode,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Store email in SharedPreferences on successful registration
        await SharedPrefsHelper.saveEmail(email);
        await SharedPrefsHelper.saveUserCode(userCode);
        return response.data['message'];  // Assuming API returns message
      } else {
        return 'Registration failed: ${response.statusCode}';
      }
    } catch (e) {
      return 'Registration failed: $e';
    }
  }

  // Login function
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        // Store email in SharedPreferences on successful login
        await SharedPrefsHelper.saveEmail(email);
        return response.data;  // Assuming response contains user info
      } else {
        return {'error': 'Login failed: ${response.statusCode}'};
      }
    } catch (e) {
      return {'error': 'Login failed: $e'};
    }
  }

  // Fetch user code method (new method)
  Future<String?> fetchUserCode(String email) async {
    try {
      // Making GET request to fetch the user code based on userId
      Response response = await _dio.get('/user/$email/user_code');

      if (response.statusCode == 200) {
        return response.data['user_code']; // Return the unique code
      } else {
        return null; // If no code is found or error occurs
      }
    } catch (e) {
      print('Error fetching user code: $e');
      return null;
    }
  }


}
