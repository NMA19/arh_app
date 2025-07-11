import 'package:flutter/material.dart';
import 'BaseNavigationWidget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteImages = [
      'Frame (1).png',
      'Frame (2).png',
      'Frame (3).png',
      'Frame (4).png',
      'Frame (5).png',
      'Frame.png',
    ];

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
              // Custom staggered grid layout
              _buildStaggeredGrid(favoriteImages),
              const SizedBox(height: 20), // Extra space at bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStaggeredGrid(List<String> favoriteImages) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column
            Expanded(
              child: Column(
                children: [
                  _buildImageCard(favoriteImages[0], 200), // Tall
                  const SizedBox(height: 16),
                  _buildImageCard(favoriteImages[2], 150), // Short
                  const SizedBox(height: 16),
                  _buildImageCard(favoriteImages[4], 180), // Medium
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Right column
            Expanded(
              child: Column(
                children: [
                  _buildImageCard(favoriteImages[1], 150), // Short
                  const SizedBox(height: 16),
                  _buildImageCard(favoriteImages[3], 220), // Tall
                  const SizedBox(height: 16),
                  if (favoriteImages.length > 5)
                    _buildImageCard(favoriteImages[5], 160), // Medium
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageCard(String imagePath, double height) {
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
      child: Column(
        children: [
          // Image section
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F9FA),
                ),
                child: Image.asset(
                  'assets/images/Favorite/$imagePath',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Action buttons section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7993AE).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.chat_bubble_outline,
                        color: Color(0xFF7993AE),
                        size: 18,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}