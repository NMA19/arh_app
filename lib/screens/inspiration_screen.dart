import 'package:flutter/material.dart';
import 'CurvedBottomNavigationBar.dart';
import 'Home_screen.dart';
import 'FavoritesScreen.dart';
import 'StoreScreen.dart';
import 'ProfileScreen.dart';

class InspirationScreen extends StatefulWidget {
  const InspirationScreen({super.key});

  @override
  State<InspirationScreen> createState() => _InspirationScreenState();
}

class _InspirationScreenState extends State<InspirationScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FavoritesScreen()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StoreScreen()));
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
    }
  }

  void _onFabPressed() {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('Search'),
        content: Text('Search functionality will be implemented here.'),
      ),
    );
  }

  Widget _buildImageGrid(String topic, List<String> imageNames) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          topic,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF586C7C),
          ),
        ),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.2,
          children: imageNames.map((img) {
            return Container(
              height: 80, // smaller height (approx 50%)
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFF7993AE).withOpacity(0.3)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.asset(
                  'assets/images/$topic/$img',
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final topic1Images = [
      'Frame.png',
      'Frame (2).png',
      'Frame (3).png',
      'Frame (4).png',
      'Frame (5).png',
    ];

    final topic2Images = [
      'Auto Layout Horizontal.png',
      'Frame (1).png',
      'Frame (2).png',
      'Frame (3).png',
      'Frame (4).png',
      'Frame.png',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo aligned left
              Image.asset(
                'assets/icons/app_icon.png',
                width: 96,
                height: 96,
              ),
              const SizedBox(height: 16),

              // Search bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF7993AE).withOpacity(0.3)),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Color(0xFF7993AE)),
                    hintText: 'Search inspirations...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Topic 1
              _buildImageGrid('Topic1', topic1Images),

              // Topic 2
              _buildImageGrid('Topic2', topic2Images),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF7993AE),
        unselectedItemColor: Colors.grey,
        fabIcon: Container(
          padding: const EdgeInsets.all(2),
          child: Image.asset(
            'assets/icons/Search.png',
            width: 24,
            height: 24,
            color: Colors.white,
          ),
        ),
        fabBackgroundColor: const Color(0xFF7993AE),
        onFabPressed: _onFabPressed,
        items: const [
          CurvedBottomNavigationBarItem(icon: Icons.home, label: 'Home'),
          CurvedBottomNavigationBarItem(icon: Icons.favorite, label: 'Favorites'),
          CurvedBottomNavigationBarItem(icon: Icons.store, label: 'Store'),
          CurvedBottomNavigationBarItem(icon: Icons.person, label: 'Profile'),
        ],
      ),
    );
  }
}
