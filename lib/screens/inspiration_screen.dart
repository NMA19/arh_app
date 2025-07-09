import 'package:flutter/material.dart';
import 'CurvedBottomNavigationBar.dart'; // Fixed import with correct case

class InspirationScreen extends StatefulWidget {
  const InspirationScreen({super.key});

  @override
  State<InspirationScreen> createState() => _InspirationScreenState();
}

class _InspirationScreenState extends State<InspirationScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0; // Default to home since this is accessed from home
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _animationController.reset();
    _animationController.forward();

    // Handle navigation
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FavoritesScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const StoreScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  void _onFabPressed() {
    // Handle search functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search'),
        content: const Text('Search functionality will be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Inspiration'),
        backgroundColor: const Color(0xFF7993AE),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF7993AE).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          size: 32,
                          color: Color(0xFF7993AE),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Design Inspiration',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF586C7C),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Browse through various design ideas to fuel your creativity',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Categories section
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF586C7C),
                ),
              ),
              const SizedBox(height: 16),

              // Category grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildCategoryCard(
                    'Modern',
                    Icons.home_work,
                    'Clean lines and minimalist design',
                  ),
                  _buildCategoryCard(
                    'Traditional',
                    Icons.house,
                    'Classic and timeless architecture',
                  ),
                  _buildCategoryCard(
                    'Industrial',
                    Icons.factory,
                    'Raw materials and exposed elements',
                  ),
                  _buildCategoryCard(
                    'Minimalist',
                    Icons.crop_free,
                    'Less is more philosophy',
                  ),
                  _buildCategoryCard(
                    'Sustainable',
                    Icons.eco,
                    'Eco-friendly and green building',
                  ),
                  _buildCategoryCard(
                    'Futuristic',
                    Icons.rocket_launch,
                    'Next-generation design concepts',
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Featured designs section
              const Text(
                'Featured Designs',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF586C7C),
                ),
              ),
              const SizedBox(height: 16),

              // Placeholder for featured designs
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        size: 48,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Featured designs will appear here',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        items: const [
          CurvedBottomNavigationBarItem(
            icon: Icons.home,
            label: 'Home',
          ),
          CurvedBottomNavigationBarItem(
            icon: Icons.favorite,
            label: 'Favorites',
          ),
          CurvedBottomNavigationBarItem(
            icon: Icons.store,
            label: 'Store',
          ),
          CurvedBottomNavigationBarItem(
            icon: Icons.person,
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF7993AE),
        unselectedItemColor: Colors.grey[600]!,
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
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, String description) {
    return GestureDetector(
      onTap: () {
        // Handle category tap
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title category selected'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF7993AE).withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: const Color(0xFF7993AE),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF586C7C),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// These classes need to be imported from your other files or defined here
// I'm adding placeholder implementations assuming they exist in your project

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This should return your actual HomeScreen widget
    return const Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Favorites Screen'),
      ),
    );
  }
}

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Store Screen'),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}