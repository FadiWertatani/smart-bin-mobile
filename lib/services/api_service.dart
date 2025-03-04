import 'package:dio/dio.dart';
import 'package:smar_bin/services/SharedPrefsHelper.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class ApiService {
  static const String BASE_URL = 'http://192.168.16.1:5000';

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

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });

      // If request succeeds, process the response
      Map<String, dynamic> userData = response.data['user'];
      String token = response.data['token'];
      String userCode = userData['user_code'];

      // Save data in SharedPreferences
      await SharedPrefsHelper.saveEmail(email);
      await SharedPrefsHelper.saveToken(token);
      await SharedPrefsHelper.saveUserCode(userCode);

      return response.data;
    }
    on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          return {'error': 'Incorrect password'};
        }
        else if (e.response!.statusCode == 404) {
          return {'error': 'Email not found'};
        }
        else {
          return {'error': 'Unexpected error: ${e.response!.statusCode}'};
        }
      } else {
        return {'error': 'Network error: ${e.message}'};
      }
    } catch (e) {
      return {'error': 'Login failed: ${e.toString()}'};
    }
  }

  // Logout user method
  Future<Map<String, dynamic>> logoutUser() async {
    try {
      // Making a POST request to the server to log out the user
      Response response = await _dio.post('/logout');

      if (response.statusCode == 200) {
        // On successful logout, clear all user data from SharedPreferences
        await SharedPrefsHelper.clearData();

        return {'message': 'Logout successful'};
      } else {
        return {'error': 'Logout failed: ${response.statusCode}'};
      }
    } catch (e) {
      return {'error': 'Logout failed: $e'};
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

  Future<String?> getUserProfileImage(String email) async {
    try {
      // Request to fetch the profile image URL for the user
      Response response = await _dio.get('/user/$email/profile-image');

      if (response.statusCode == 200) {
        // Assuming the API returns the profile image path
        return response.data['profile_image']; // Return image path or URL
      } else {
        return null; // If the request fails or image not found
      }
    } catch (e) {
      print('Error fetching user profile image: $e');
      return null; // Return null in case of error
    }
  }


  Future<bool> uploadProfileImage(String userCode, File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path, filename: fileName),
        'user_code': userCode,
      });

      Response response = await _dio.post('/upload-profile-image', data: formData);
      return response.statusCode == 200;
    } catch (e) {
      print('Error uploading image: $e');
      return false;
    }
  }

  // Fetch staff list based on clinic
  Future<List<Map<String, dynamic>>> fetchStaffsList(String clinic) async {
    try {
      Response response = await _dio.get('/staff', queryParameters: {'clinic': clinic});

      if (response.statusCode == 200) {
        // Returning the list of doctors
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching staff list: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getUserData(String userCode) async {
    try {
      Response response = await _dio.get('/user/$userCode/data');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {
          'error': 'Erreur lors de la récupération des données',
          'name': '',
          'points': [],
        };
      }
    } catch (e) {
      print('Error getting user data: $e');
      return {
        'error': 'Erreur lors de la récupération des données',
        'name': '',
        'points': [],
      };
    }
  }
}
