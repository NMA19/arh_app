import 'package:flutter/material.dart';
import 'CurvedBottomNavigationBar.dart';
import 'FavoritesScreen.dart';
import 'StoreScreen.dart';
import 'ProfileScreen.dart';
import 'details_screen.dart';
import 'inspiration_screen.dart' show InspirationScreen;
import 'ar_viewer_screen.dart';
import 'ai_scanner_screen.dart';
import 'discober_screen.dart';
import 'sos_screen.dart';
import 'magicPlan_screen.dart';
import 'LoadEas_screen.dart';
import 'chatboot_screen.dart';
import 'startmodeling_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final TextEditingController _searchController = TextEditingController();

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
    _searchController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });
    _animationController.reset();
    _animationController.forward();

    switch (index) {
      case 0:
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
          MaterialPageRoute(builder: (context) => const DetailsScreen()),
        );
        break;
    }
  }

  void _onInspirationTapped() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InspirationScreen()),
    );
  }

  void _onSearchPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DiscoverScreen()),
    );
  }

  void _onSettingsPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  void _onSosPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SosScreen()),
    );
  }

  void _onChatbootPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatbootScreen()),
    );
  }


  void _onMagicPlanPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MagicPlanScreen()),
    );
  }
  void _onStartmodeling() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StartModelingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/app_icon.png', width: 100, height: 100),
                  const SizedBox(width: 8),
                  const Spacer(),
                  IconButton(
                    onPressed: _onSettingsPressed,
                    icon: const Icon(
                      Icons.settings,
                      color: Color(0xFF586C7C),
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  border: Border.all(color: const Color(0xFF7993AE), width: 3.0),
                  borderRadius: BorderRadius.zero,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Your Project",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF586C7C))),
                          const SizedBox(height: 8),
                          const Text("Start Modeling your\narchitectural projects here",
                              style: TextStyle(color: Colors.black54, fontSize: 13)),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _onStartmodeling,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF586C7C),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Start modeling", style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(height: 8),
                          const Text("Recent design", style: TextStyle(color: Colors.black87)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/images/Blueprint.png', fit: BoxFit.cover, height: 100),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  _buildSquareBox('assets/images/Store.png', 'Store', 'Explore furniture & decor for your project', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreScreen()));
                  }),
                  const SizedBox(width: 16),
                  _buildSquareBox('assets/images/Inspiration.png', 'Inspiration',
                      'Browse through various design ideas to fuel your creativity', _onInspirationTapped),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildSquareBox('assets/images/AI scanner.png', 'AI scanner', '', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AIScannerScreen()));
                  }),
                  const SizedBox(width: 16),
                  _buildSquareBox('assets/images/AR viewer.png', 'AR viewer', '', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ARViewerScreen()));
                  }),
                  const SizedBox(width: 16),
                  _buildSquareBox('assets/images/Magic plan.png', 'Magic plan', '', _onMagicPlanPressed),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoadEaseScreen()),
                        );
                      },
                      child: Container(
                        height: 92,
                        padding: const EdgeInsets.only(top: 36, bottom: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text(
                            'LoadEas',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: _onSosPressed,
                      child: Container(
                        height: 92,
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Image.asset('assets/images/Sos.png', width: 60, height: 60),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: _onChatbootPressed,
                      child: Container(
                        height: 92,
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chat_bubble_outline, color: Colors.black87, size: 30),
                            const SizedBox(height: 4),
                            const Text('Chatbot', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 80),
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
        fabIcon: const Icon(Icons.search, color: Colors.white),
        fabBackgroundColor: const Color(0xFF7993AE),
        onFabPressed: _onSearchPressed,
        items: const [
          CurvedBottomNavigationBarItem(icon: Icons.home, label: 'Home'),
          CurvedBottomNavigationBarItem(icon: Icons.favorite, label: 'Favorites'),
          CurvedBottomNavigationBarItem(icon: Icons.store, label: 'Store'),
          CurvedBottomNavigationBarItem(icon: Icons.info_outline, label: 'Details'),
        ],
      ),
    );
  }

  Widget _buildSquareBox(String image, String title, String description, VoidCallback? onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Image.asset(image, width: 36, height: 36),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              if (description.isNotEmpty)
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
