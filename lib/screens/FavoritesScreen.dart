import 'package:flutter/material.dart';
import 'BaseNavigationWidget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<dynamic> favorites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      // Mock data for favorites
      final favoritesList = [
        {
          'id': '1',
          'name': 'Modern Chair',
          'price': 299.99,
          'image': 'assets/images/Topic1/furniture1.jpg',
          'category': 'Furniture'
        },
        {
          'id': '2', 
          'name': 'Table Lamp',
          'price': 89.99,
          'image': 'assets/images/Topic1/lamp1.jpg',
          'category': 'Lighting'
        },
        {
          'id': '3',
          'name': 'Decorative Vase',
          'price': 45.50,
          'image': 'assets/images/Topic1/decor1.jpg',
          'category': 'Decor'
        }
      ];
      
      setState(() {
        favorites = favoritesList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Fallback to static images if API fails
      favorites = [
        {'product': {'name': 'Sample 1', 'imageUrl': 'assets/images/Favorite/Frame (1).png'}},
        {'product': {'name': 'Sample 2', 'imageUrl': 'assets/images/Favorite/Frame (2).png'}},
        {'product': {'name': 'Sample 3', 'imageUrl': 'assets/images/Favorite/Frame (3).png'}},
        {'product': {'name': 'Sample 4', 'imageUrl': 'assets/images/Favorite/Frame (4).png'}},
        {'product': {'name': 'Sample 5', 'imageUrl': 'assets/images/Favorite/Frame (5).png'}},
        {'product': {'name': 'Sample 6', 'imageUrl': 'assets/images/Favorite/Frame.png'}},
      ];
    }
  }

  Future<void> _removeFromFavorites(String productId) async {
    try {
      // Mock removal - just remove from local list
      setState(() {
        favorites.removeWhere((item) => item['id'] == productId);
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Removed from favorites')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to remove: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseNavigationWidget(
      title: '', // Empty title (no AppBar will be shown)
      selectedIndex: 1, // Index for Favorites tab
      showSearchBar: false, // Remove search bar and search icon
      child: Container(
        color: Colors.white, // White background
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo at the top - simple
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Image.asset(
                  'assets/icons/app_icon.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 32),
              // Loading or content
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : favorites.isEmpty
                      ? const Center(
                          child: Column(
                            children: [
                              Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                              SizedBox(height: 16),
                              Text(
                                'No favorites yet',
                                style: TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                              Text(
                                'Add some products to your favorites!',
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : _buildStaggeredGrid(),
              const SizedBox(height: 20), // Extra space at bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStaggeredGrid() {
    // Create two lists for left and right columns
    List<dynamic> leftColumn = [];
    List<dynamic> rightColumn = [];
    
    for (int i = 0; i < favorites.length; i++) {
      if (i % 2 == 0) {
        leftColumn.add(favorites[i]);
      } else {
        rightColumn.add(favorites[i]);
      }
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column
            Expanded(
              child: Column(
                children: leftColumn.map((favorite) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildImageCard(favorite),
                )).toList(),
              ),
            ),
            const SizedBox(width: 16),
            // Right column
            Expanded(
              child: Column(
                children: rightColumn.map((favorite) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildImageCard(favorite),
                )).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageCard(Map<String, dynamic> favorite) {
    final product = favorite['product'];
    final heights = [150.0, 180.0, 200.0, 220.0];
    final height = heights[favorites.indexOf(favorite) % heights.length];
    
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: product['imageUrl'] != null
                ? Image.asset(
                    product['imageUrl'],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.grey[200],
                        child: const Icon(Icons.favorite, size: 50, color: Colors.grey),
                      );
                    },
                  )
                : Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey[200],
                    child: const Icon(Icons.favorite, size: 50, color: Colors.grey),
                  ),
          ),
          // Product name overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product['name'] ?? 'Unknown Product',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _removeFromFavorites(product['id']),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
