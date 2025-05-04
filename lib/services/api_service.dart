import 'package:dio/dio.dart';
import 'package:smar_bin/models/User.dart';
import 'package:smar_bin/services/SharedPrefsHelper.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class ApiService {
  static const String BASE_URL = 'https://smartbin-backend.onrender.com';
  // static const String BASE_URL = 'http://192.168.43.31:5000';

  // Private constructor
  ApiService._internal();

  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Factory constructor returns the same instance
  factory ApiService() => _instance;

  final Uuid _uuid = Uuid();

  // Dio instance
  final Dio _dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  Future<String> registerUser(String name, String email, String password,
      String confirmPassword) async {
    try {
      Response response = await _dio.post('/signup', data: {
        'full_name': name,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        // Save email and user_code
        await SharedPrefsHelper.saveEmail(email);
        if (data['user_code'] != null) {
          await SharedPrefsHelper.saveUserCode(data['user_code']);
        }

        return data['message'] ?? 'Registration successful';
      } else {
        return 'Registration failed: ${response.statusCode}';
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        return e.response!.data['message'] ?? 'Unknown error occurred';
      } else {
        return 'Network error: ${e.message}';
      }
    } catch (e) {
      return 'Registration failed: $e';
    }
  }

  //login
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post('/api/login', data: {
        'email': email,
        'password': password,
      });

      final data = response.data;

      // Check for required fields
      if (data == null || data['token'] == null || data['user_code'] == null) {
        return {'error': 'Invalid response from server'};
      }

      // Save required fields
      await SharedPrefsHelper.saveEmail(data['email']);
      await SharedPrefsHelper.saveToken(data['token']);
      await SharedPrefsHelper.saveUserCode(data['user_code']);

      return data;
    } on DioException catch (e) {
      if (e.response != null) {
        final message = e.response!.data['message'] ?? 'Unexpected error';
        if (e.response!.statusCode == 401) {
          return {'error': 'Invalid email or password'};
        } else if (e.response!.statusCode == 403) {
          return {'error': message};
        } else {
          return {'error': 'Server error: ${e.response!.statusCode}'};
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

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      final response = await _dio.get('/api/users');
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error fetching users: $e');
      rethrow;
    }
  }

  Future<User> fetchUserByEmail(String email) async {
    try {
      final response = await _dio.get('/api/users/$email');

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch user');
      }
    } catch (e) {
      print('Error fetching user by email: $e');
      rethrow;
    }
  }

  /// Fetch gift points by email
  Future<int?> getGiftPointsByEmail(String email) async {
    try {
      final response = await _dio.get('/api/users/giftpoints/$email');

      if (response.statusCode == 200) {
        return response.data['giftpoints'];
      } else if (response.statusCode == 404) {
        print('Data not found');
        return null;
      } else {
        print('Unexpected error: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      return null;
    } catch (e) {
      print('Unknown error: $e');
      return null;
    }
  }

  // // Fetch user code method (new method)
  // Future<String?> fetchUserCode(String email) async {
  //   try {
  //     // Making GET request to fetch the user code based on userId
  //     Response response = await _dio.get('/user/$email/user_code');
  //
  //     if (response.statusCode == 200) {
  //       return response.data['user_code']; // Return the unique code
  //     } else {
  //       return null; // If no code is found or error occurs
  //     }
  //   } catch (e) {
  //     print('Error fetching user code: $e');
  //     return null;
  //   }
  // }

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

  Future<bool> uploadProfileImage(String email, File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path, filename: fileName),
        'email': email,
      });

      Response response = await _dio.post('/upload-profile-image', data: formData);

      return response.statusCode == 200;
    } catch (e) {
      print('Error uploading image: $e');
      return false;
    }
  }

//
  // // Fetch staff list based on clinic
  // Future<List<Map<String, dynamic>>> fetchStaffsList(String clinic) async {
  //   try {
  //     Response response =
  //         await _dio.get('/staff', queryParameters: {'clinic': clinic});
  //
  //     if (response.statusCode == 200) {
  //       // Returning the list of doctors
  //       return List<Map<String, dynamic>>.from(response.data);
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     print('Error fetching staff list: $e');
  //     return [];
  //   }
  // }
  //
  // Future<Map<String, dynamic>> getUserData(String userCode) async {
  //   try {
  //     Response response = await _dio.get('/user/$userCode/data');
  //     if (response.statusCode == 200) {
  //       return response.data;
  //     } else {
  //       return {
  //         'error': 'Erreur lors de la récupération des données',
  //         'name': '',
  //         'points': [],
  //       };
  //     }
  //   } catch (e) {
  //     print('Error getting user data: $e');
  //     return {
  //       'error': 'Erreur lors de la récupération des données',
  //       'name': '',
  //       'points': [],
  //     };
  //   }
  // }
}
