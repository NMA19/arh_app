import 'api_service.dart';

class ARService {
  static Future<Map<String, dynamic>> getARModels({
    String? category,
    int? productId,
  }) async {
    try {
      String endpoint = '/ar/models';
      Map<String, String> queryParams = {};
      
      if (category != null) queryParams['category'] = category;
      if (productId != null) queryParams['productId'] = productId.toString();
      
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
        'error': 'Failed to load AR models: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> createARScene({
    required String name,
    String? description,
    String? roomType,
    required List<Map<String, dynamic>> models,
  }) async {
    try {
      final response = await ApiService.post('/ar/scenes', {
        'name': name,
        'description': description,
        'roomType': roomType,
        'models': models,
      });
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to create AR scene: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> getARScenes() async {
    try {
      final response = await ApiService.get('/ar/scenes');
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to load AR scenes: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> updateARScene({
    required int sceneId,
    String? name,
    String? description,
    String? roomType,
    List<Map<String, dynamic>>? models,
    bool? isPublic,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (description != null) data['description'] = description;
      if (roomType != null) data['roomType'] = roomType;
      if (models != null) data['models'] = models;
      if (isPublic != null) data['isPublic'] = isPublic;

      final response = await ApiService.put('/ar/scenes/$sceneId', data);
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to update AR scene: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> createMagicPlan({
    required String roomName,
    required Map<String, dynamic> measurements,
    required Map<String, dynamic> floorPlan,
    required List<Map<String, dynamic>> furniture,
  }) async {
    try {
      final response = await ApiService.post('/ar/magic-plan', {
        'roomName': roomName,
        'measurements': measurements,
        'floorPlan': floorPlan,
        'furniture': furniture,
      });
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to create magic plan: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> getMagicPlans() async {
    try {
      final response = await ApiService.get('/ar/magic-plans');
      return response;
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to load magic plans: $e',
      };
    }
  }
}
