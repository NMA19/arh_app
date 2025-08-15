import 'api_service.dart';

class HomeService {
  static Future<Map<String, dynamic>> getDashboardData() async {
    try {
      final response = await ApiService.get('/home/dashboard');
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to load dashboard: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> getFeaturedContent() async {
    try {
      final response = await ApiService.get('/home/featured');
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to load featured content: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> globalSearch({
    required String query,
    String? category,
    String? type,
  }) async {
    try {
      String endpoint = '/home/search?q=$query';
      if (category != null) endpoint += '&category=$category';
      if (type != null) endpoint += '&type=$type';

      final response = await ApiService.get(endpoint);
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Search failed: $e',
      };
    }
  }
}
