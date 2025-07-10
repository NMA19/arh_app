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
      title: 'Favorites',
      selectedIndex: 1, // Index for Favorites tab
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/icons/app_icon.png',
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: favoriteImages.map((image) {
                return Container(
                  width: (MediaQuery.of(context).size.width - 48) / 2,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          'assets/images/Favorite/$image',
                          fit: BoxFit.cover,
                          height: 120,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.favorite_border, color: Color(0xFF7993AE), size: 20),
                                SizedBox(width: 6),
                                Icon(Icons.comment, color: Color(0xFF7993AE), size: 20),
                              ],
                            ),
                            const Icon(Icons.more_vert, color: Colors.grey, size: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
