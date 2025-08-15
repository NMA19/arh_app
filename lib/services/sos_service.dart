import 'api_service.dart';

class SOSService {
  static Future<Map<String, dynamic>> createSOSRequest({
    required String type,
    required String message,
    String? location,
    double? latitude,
    double? longitude,
    String urgency = 'medium',
    String? contactInfo,
  }) async {
    try {
      final response = await ApiService.post('/sos/request', {
        'type': type,
        'message': message,
        'location': location,
        'latitude': latitude,
        'longitude': longitude,
        'urgency': urgency,
        'contactInfo': contactInfo,
      });
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to create SOS request: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> getSOSRequests() async {
    try {
      final response = await ApiService.get('/sos/requests');
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to load SOS requests: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> updateSOSRequest({
    required String requestId,
    String? status,
    String? message,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (status != null) data['status'] = status;
      if (message != null) data['message'] = message;

      final response = await ApiService.put('/sos/requests/$requestId', data);
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to update SOS request: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> getArtisans({
    double? latitude,
    double? longitude,
    String? profession,
  }) async {
    try {
      String endpoint = '/sos/artisans';
      Map<String, String> queryParams = {};
      
      if (latitude != null) queryParams['lat'] = latitude.toString();
      if (longitude != null) queryParams['lng'] = longitude.toString();
      if (profession != null) queryParams['profession'] = profession;
      
      if (queryParams.isNotEmpty) {
        endpoint += '?' + queryParams.entries
            .map((e) => '${e.key}=${e.value}')
            .join('&');
      }

      final response = await ApiService.get(endpoint);
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to load artisans: $e',
      };
    }
  }
}
