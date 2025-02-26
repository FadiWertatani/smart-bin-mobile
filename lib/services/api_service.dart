import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.19:5000', // Replace with your actual IP
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  Future<String> registerUser(String name, String email, String password, clinic) async {
    try {
      Response response = await _dio.post('/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'clinic' : clinic
      });

      return response.data['message'];
    } catch (e) {
      return 'Registration failed: $e';
    }
  }
}
