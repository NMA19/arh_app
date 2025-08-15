import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoritesService {
  static const String baseUrl = "http://localhost:3000/api/favorites";

  static Future<List<dynamic>> getFavorites() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['favorites'] ?? [];
      } else {
        throw Exception("Failed to load favorites");
      }
    } catch (e) {
      // Return empty list if service is unavailable
      return [];
    }
  }

  static Future<void> addToFavorites(String productId) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"productId": productId}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Failed to add to favorites");
      }
    } catch (e) {
      throw Exception("Failed to add to favorites: $e");
    }
  }

  static Future<void> removeFromFavorites(String productId) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$productId"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to remove from favorites");
      }
    } catch (e) {
      throw Exception("Failed to remove from favorites: $e");
    }
  }
}
