import 'package:dio/dio.dart';

class ApiService {
  // Private constructor
  ApiService._internal();

  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Factory constructor returns the same instance
  factory ApiService() => _instance;

  // Dio instance
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.19:5000', // Replace with your actual IP
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  Future<String> registerUser(String name, String email, String password, String clinic) async {
    try {
      Response response = await _dio.post('/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'clinic': clinic,
      });

      return response.data['message'];
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

      return response.data; // Expecting JSON response
    } catch (e) {
      return {'error': 'Login failed: $e'};
    }
  }

}
