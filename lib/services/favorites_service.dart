import '../services/api_service.dart';

class FavoritesService {
  // Get user's favorites
  static Future<List<dynamic>> getFavorites() async {
    try {
      final response = await ApiService.get('/favorites');
      return response['favorites'] ?? [];
    } catch (e) {
      throw Exception('Failed to load favorites: $e');
    }
  }
  
  // Add product to favorites
  static Future<Map<String, dynamic>> addToFavorites(String productId) async {
    try {
      return await ApiService.post('/favorites', {
        'productId': productId,
      });
    } catch (e) {
      throw Exception('Failed to add to favorites: $e');
    }
  }
  
  // Remove product from favorites
  static Future<Map<String, dynamic>> removeFromFavorites(String productId) async {
    try {
      return await ApiService.delete('/favorites/$productId');
    } catch (e) {
      throw Exception('Failed to remove from favorites: $e');
    }
  }
  
  // Check if product is in favorites
  static Future<bool> isFavorite(String productId) async {
    try {
      final favorites = await getFavorites();
      return favorites.any((fav) => fav['product']['id'] == productId);
    } catch (e) {
      return false;
    }
  }
}
