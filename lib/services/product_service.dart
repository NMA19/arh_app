import '../services/api_service.dart';

class ProductService {
  // Get all products with optional filters
  static Future<Map<String, dynamic>> getProducts({
    int page = 1,
    int limit = 20,
    String? search,
    String? category,
    String? brand,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      String endpoint = '/products?page=$page&limit=$limit';
      
      if (search != null && search.isNotEmpty) {
        endpoint += '&search=$search';
      }
      if (category != null && category.isNotEmpty) {
        endpoint += '&category=$category';
      }
      if (brand != null && brand.isNotEmpty) {
        endpoint += '&brand=$brand';
      }
      if (minPrice != null) {
        endpoint += '&minPrice=$minPrice';
      }
      if (maxPrice != null) {
        endpoint += '&maxPrice=$maxPrice';
      }
      
      return await ApiService.get(endpoint);
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
  
  // Get product by ID
  static Future<Map<String, dynamic>> getProduct(String productId) async {
    try {
      return await ApiService.get('/products/$productId');
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }
  
  // Create new product
  static Future<Map<String, dynamic>> createProduct({
    required String name,
    required String description,
    required double price,
    required String categoryId,
    required String brandId,
    String? imageUrl,
    String? arModelUrl,
    Map<String, dynamic>? specifications,
    List<String>? tags,
  }) async {
    try {
      return await ApiService.post('/products', {
        'name': name,
        'description': description,
        'price': price,
        'categoryId': categoryId,
        'brandId': brandId,
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (arModelUrl != null) 'arModelUrl': arModelUrl,
        if (specifications != null) 'specifications': specifications,
        if (tags != null) 'tags': tags,
      });
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }
  
  // Update product
  static Future<Map<String, dynamic>> updateProduct(String productId, Map<String, dynamic> data) async {
    try {
      return await ApiService.put('/products/$productId', data);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }
  
  // Delete product
  static Future<Map<String, dynamic>> deleteProduct(String productId) async {
    try {
      return await ApiService.delete('/products/$productId');
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
  
  // Get user's products
  static Future<Map<String, dynamic>> getUserProducts() async {
    try {
      return await ApiService.get('/products/my-products');
    } catch (e) {
      throw Exception('Failed to load user products: $e');
    }
  }
}
