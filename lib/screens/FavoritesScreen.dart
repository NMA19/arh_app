import 'package:flutter/material.dart';
import 'BaseNavigationWidget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseNavigationWidget(
      title: 'Favorites',
      selectedIndex: 1,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite, size: 80, color: Color(0xFF7993AE)),
            SizedBox(height: 16),
            Text(
              'Your Favorites',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Save your favorite architecture designs here',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}