import '../services/api_service.dart';

class MetadataService {
  // Get all categories
  static Future<List<dynamic>> getCategories() async {
    try {
      final response = await ApiService.get('/metadata/categories');
      return response['categories'] ?? [];
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
  
  // Get all brands
  static Future<List<dynamic>> getBrands() async {
    try {
      final response = await ApiService.get('/metadata/brands');
      return response['brands'] ?? [];
    } catch (e) {
      throw Exception('Failed to load brands: $e');
    }
  }
  
  // Get category by ID
  static Future<Map<String, dynamic>> getCategory(String categoryId) async {
    try {
      return await ApiService.get('/metadata/categories/$categoryId');
    } catch (e) {
      throw Exception('Failed to load category: $e');
    }
  }
  
  // Get brand by ID
  static Future<Map<String, dynamic>> getBrand(String brandId) async {
    try {
      return await ApiService.get('/metadata/brands/$brandId');
    } catch (e) {
      throw Exception('Failed to load brand: $e');
    }
  }
  
  // Create category
  static Future<Map<String, dynamic>> createCategory({
    required String name,
    required String description,
    String? imageUrl,
  }) async {
    try {
      return await ApiService.post('/metadata/categories', {
        'name': name,
        'description': description,
        if (imageUrl != null) 'imageUrl': imageUrl,
      });
    } catch (e) {
      throw Exception('Failed to create category: $e');
    }
  }
  
  // Create brand
  static Future<Map<String, dynamic>> createBrand({
    required String name,
    required String description,
    String? logoUrl,
    String? website,
  }) async {
    try {
      return await ApiService.post('/metadata/brands', {
        'name': name,
        'description': description,
        if (logoUrl != null) 'logoUrl': logoUrl,
        if (website != null) 'website': website,
      });
    } catch (e) {
      throw Exception('Failed to create brand: $e');
    }
  }
}
