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
    baseUrl: 'http://172.16.6.179:5000', // Replace with your actual IP
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
}
