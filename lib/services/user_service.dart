import '../services/api_service.dart';

class UserService {
  // Get current user profile
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      return await ApiService.get('/users/profile');
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }
  
  // Update user profile
  static Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    try {
      return await ApiService.put('/users/profile', data);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
  
  // Get user preferences
  static Future<Map<String, dynamic>> getPreferences() async {
    try {
      return await ApiService.get('/users/preferences');
    } catch (e) {
      throw Exception('Failed to load preferences: $e');
    }
  }
  
  // Update user preferences
  static Future<Map<String, dynamic>> updatePreferences(Map<String, dynamic> preferences) async {
    try {
      return await ApiService.put('/users/preferences', {'preferences': preferences});
    } catch (e) {
      throw Exception('Failed to update preferences: $e');
    }
  }
}
