import 'dart:convert';
import 'package:http/http.dart' as http;

class MetadataService {
  static const String baseUrl = "http://localhost:3000/api";

  static Future<List<dynamic>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/categories"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['categories'] ?? [];
      } else {
        // Return default categories if service is unavailable
        return [
          {'id': 'all', 'name': 'All Products'},
          {'id': 'furniture', 'name': 'Furniture'},
          {'id': 'decor', 'name': 'Decor'},
          {'id': 'lighting', 'name': 'Lighting'},
          {'id': 'kitchen', 'name': 'Kitchen'},
          {'id': 'bedroom', 'name': 'Bedroom'},
          {'id': 'bathroom', 'name': 'Bathroom'},
          {'id': 'outdoor', 'name': 'Outdoor'},
        ];
      }
    } catch (e) {
      // Return default categories if service is unavailable
      return [
        {'id': 'all', 'name': 'All Products'},
        {'id': 'furniture', 'name': 'Furniture'},
        {'id': 'decor', 'name': 'Decor'},
        {'id': 'lighting', 'name': 'Lighting'},
        {'id': 'kitchen', 'name': 'Kitchen'},
        {'id': 'bedroom', 'name': 'Bedroom'},
        {'id': 'bathroom', 'name': 'Bathroom'},
        {'id': 'outdoor', 'name': 'Outdoor'},
      ];
    }
  }

  static Future<Map<String, dynamic>> getAppSettings() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/settings"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // Return default settings
        return {
          'version': '1.0.0',
          'features': {
            'aiScanner': true,
            'arViewer': true,
            'magicPlan': true,
            'chat': true,
          }
        };
      }
    } catch (e) {
      // Return default settings
      return {
        'version': '1.0.0',
        'features': {
          'aiScanner': true,
          'arViewer': true,
          'magicPlan': true,
          'chat': true,
        }
      };
    }
  }

  static Future<List<dynamic>> getFilters() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/filters"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['filters'] ?? [];
      } else {
        // Return default filters
        return [
          {
            'type': 'price',
            'name': 'Price Range',
            'options': [
              {'value': '0-100', 'label': '\$0 - \$100'},
              {'value': '100-500', 'label': '\$100 - \$500'},
              {'value': '500-1000', 'label': '\$500 - \$1000'},
              {'value': '1000+', 'label': '\$1000+'},
            ]
          },
          {
            'type': 'rating',
            'name': 'Rating',
            'options': [
              {'value': '4+', 'label': '4+ Stars'},
              {'value': '3+', 'label': '3+ Stars'},
              {'value': '2+', 'label': '2+ Stars'},
            ]
          }
        ];
      }
    } catch (e) {
      // Return default filters
      return [
        {
          'type': 'price',
          'name': 'Price Range',
          'options': [
            {'value': '0-100', 'label': '\$0 - \$100'},
            {'value': '100-500', 'label': '\$100 - \$500'},
            {'value': '500-1000', 'label': '\$500 - \$1000'},
            {'value': '1000+', 'label': '\$1000+'},
          ]
        },
        {
          'type': 'rating',
          'name': 'Rating',
          'options': [
            {'value': '4+', 'label': '4+ Stars'},
            {'value': '3+', 'label': '3+ Stars'},
            {'value': '2+', 'label': '2+ Stars'},
          ]
        }
      ];
    }
  }
}
