import 'dart:convert';
import '../services/api_service.dart';

class AuthService {
  // Login with email
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await ApiService.post('/auth/login', {
        'email': email,
        'password': password,
      });
      
      if (response['token'] != null) {
        await ApiService.setToken(response['token']);
      }
      
      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
  
  // Login with phone
  static Future<Map<String, dynamic>> loginWithPhone(String phone, String password) async {
    try {
      final response = await ApiService.post('/auth/login', {
        'phone': phone,
        'password': password,
      });
      
      if (response['token'] != null) {
        await ApiService.setToken(response['token']);
      }
      
      return response;
    } catch (e) {
      throw Exception('Phone login failed: $e');
    }
  }
  
  // Register new user
  static Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? phone,
    String? username,
  }) async {
    try {
      final response = await ApiService.post('/auth/register', {
        'email': email,
        'password': password,
        'name': '$firstName ${lastName.isNotEmpty ? lastName : ''}'.trim(),
        'username': username ?? email.split('@').first,
        if (phone != null) 'phone': phone,
      });
      
      if (response['token'] != null) {
        await ApiService.setToken(response['token']);
      }
      
      return response;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
  
  // Send phone verification
  static Future<Map<String, dynamic>> sendPhoneVerification(String phone) async {
    try {
      return await ApiService.post('/auth/send-verification', {
        'phone': phone,
      });
    } catch (e) {
      throw Exception('Phone verification failed: $e');
    }
  }
  
  // Verify phone code
  static Future<Map<String, dynamic>> verifyPhone(String phone, String code) async {
    try {
      return await ApiService.post('/auth/verify-phone', {
        'phone': phone,
        'code': code,
      });
    } catch (e) {
      throw Exception('Phone verification failed: $e');
    }
  }
  
  // Reset password
  static Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      return await ApiService.post('/auth/forgot-password-email', {
        'email': email,
      });
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }
  
  // Confirm password reset with code
  static Future<Map<String, dynamic>> confirmPasswordReset(
    String email, 
    String code, 
    String newPassword
  ) async {
    try {
      return await ApiService.post('/auth/reset-password', {
        'email': email,
        'code': code,
        'newPassword': newPassword,
      });
    } catch (e) {
      throw Exception('Password reset confirmation failed: $e');
    }
  }
  
  // Social login - Google
  static Future<Map<String, dynamic>> loginWithGoogle() async {
    try {
      // This would typically use Google Sign-In plugin
      // For now, redirect to web OAuth
      throw Exception('Google login not yet implemented in Flutter app');
    } catch (e) {
      throw Exception('Google login failed: $e');
    }
  }
  
  // Social login - Facebook
  static Future<Map<String, dynamic>> loginWithFacebook() async {
    try {
      // This would typically use Facebook Login plugin
      // For now, redirect to web OAuth
      throw Exception('Facebook login not yet implemented in Flutter app');
    } catch (e) {
      throw Exception('Facebook login failed: $e');
    }
  }
  
  // Logout
  static Future<void> logout() async {
    await ApiService.setToken('');
  }
  
  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await ApiService.getToken();
    return token != null && token.isNotEmpty;
  }
}
