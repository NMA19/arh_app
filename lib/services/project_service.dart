import '../services/api_service.dart';

class ProjectService {
  // Get user's projects
  static Future<List<dynamic>> getProjects() async {
    try {
      final response = await ApiService.get('/projects');
      return response['projects'] ?? [];
    } catch (e) {
      throw Exception('Failed to load projects: $e');
    }
  }
  
  // Get project by ID
  static Future<Map<String, dynamic>> getProject(String projectId) async {
    try {
      return await ApiService.get('/projects/$projectId');
    } catch (e) {
      throw Exception('Failed to load project: $e');
    }
  }
  
  // Create new project
  static Future<Map<String, dynamic>> createProject({
    required String name,
    required String description,
    String? thumbnailUrl,
    String? arSceneData,
    List<String>? productIds,
  }) async {
    try {
      return await ApiService.post('/projects', {
        'name': name,
        'description': description,
        if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
        if (arSceneData != null) 'arSceneData': arSceneData,
        if (productIds != null) 'productIds': productIds,
      });
    } catch (e) {
      throw Exception('Failed to create project: $e');
    }
  }
  
  // Update project
  static Future<Map<String, dynamic>> updateProject(String projectId, Map<String, dynamic> data) async {
    try {
      return await ApiService.put('/projects/$projectId', data);
    } catch (e) {
      throw Exception('Failed to update project: $e');
    }
  }
  
  // Delete project
  static Future<Map<String, dynamic>> deleteProject(String projectId) async {
    try {
      return await ApiService.delete('/projects/$projectId');
    } catch (e) {
      throw Exception('Failed to delete project: $e');
    }
  }
  
  // Add product to project
  static Future<Map<String, dynamic>> addProductToProject(String projectId, String productId) async {
    try {
      return await ApiService.post('/projects/$projectId/products', {
        'productId': productId,
      });
    } catch (e) {
      throw Exception('Failed to add product to project: $e');
    }
  }
  
  // Remove product from project
  static Future<Map<String, dynamic>> removeProductFromProject(String projectId, String productId) async {
    try {
      return await ApiService.delete('/projects/$projectId/products/$productId');
    } catch (e) {
      throw Exception('Failed to remove product from project: $e');
    }
  }
}
