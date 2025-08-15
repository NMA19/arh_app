import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class AIService {
  static const String _baseUrl = ApiService.baseUrl;

  static Future<Map<String, dynamic>> scanProduct(File imageFile) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/ai/scan'),
      );

      // Add authorization header
      final token = await ApiService.getToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      // Add image file
      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'error': data['error'] ?? 'Scan failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> getScanHistory() async {
    try {
      final response = await ApiService.get('/ai/scans');
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to load scan history: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> getRecommendations({
    int? scanId,
    Map<String, dynamic>? preferences,
  }) async {
    try {
      final response = await ApiService.post('/ai/recommend', {
        'scanId': scanId,
        'preferences': preferences,
      });
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to get recommendations: $e',
      };
    }
  }
}
