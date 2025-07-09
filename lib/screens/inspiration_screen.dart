import 'package:flutter/material.dart';

class InspirationScreen extends StatelessWidget {
  const InspirationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Logo
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/icons/app_icon.png',
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image, size: 50, color: Colors.grey),
                  );
                },
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search ideas...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: const Color(0xFFD9D9D9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTopicSection("Topic 1", "assets/images/Topic1"),
                    const SizedBox(height: 24),
                    buildTopicSection("Topic 2", "assets/images/Topic2"),
                    const SizedBox(height: 20), // Add bottom padding
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Important for 4+ items
        currentIndex: 1,
        selectedItemColor: const Color(0xFF7993AE),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle navigation
          switch (index) {
            case 0:
            // Navigate to Home
              break;
            case 1:
            // Stay on Inspiration
              break;
            case 2:
            // Navigate to Store
              break;
            case 3:
            // Navigate to Profile
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Inspiration'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget buildTopicSection(String title, String folderPath) {
    final List<String> images = List.generate(
      10,
          (index) => '$folderPath/Frame (${index + 1}).png',
    )..insert(0, '$folderPath/Frame.png'); // Add Frame.png first

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF586C7C),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: images.map((img) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                img,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image, size: 50, color: Colors.grey),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}