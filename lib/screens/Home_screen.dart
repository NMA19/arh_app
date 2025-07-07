import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF586C7C),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo (Left and Bigger)
            Row(
              children: [
                Image.asset('assets/icons/app_icon.png', width: 100, height: 100),
              ],
            ),
            const SizedBox(height: 20),

            // Your Project Box
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Project",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF586C7C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Start Modeling your\narchitectural projects here",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDED2C8),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Start modeling",
                      style: TextStyle(color: Color(0xFF586C7C)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Recent design", style: TextStyle(color: Colors.black87)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/Blueprint.png',
                          width: 100,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Store and Inspiration
            Row(
              children: [
                _buildSquareBox('assets/images/Store.png', 'Store', 'Explore items to use.'),
                const SizedBox(width: 16),
                _buildSquareBox('assets/images/Inspiration.png', 'Inspiration', 'Discover ideas.'),
              ],
            ),
            const SizedBox(height: 16),

            // AI, AR, Magic Plan
            Row(
              children: [
                _buildSquareBox('assets/images/AI scanner.png', 'AI Scanner', ''),
                const SizedBox(width: 16),
                _buildSquareBox('assets/images/AR viewer.png', 'AR Viewer', ''),
                const SizedBox(width: 16),
                _buildSquareBox('assets/images/Magic plan.png', 'Magic Plan', ''),
              ],
            ),
            const SizedBox(height: 16),

            // LeadEas and SOS
            Row(
              children: [
                _buildSquareBox('', 'LeadEas', ''),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Image.asset('assets/images/Sos.png', width: 36, height: 36),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(Icons.home, 0),
              _buildBottomNavItem(Icons.favorite, 1),
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFDED2C8),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Image.asset('assets/icons/Search.png', width: 24, height: 24),
                  onPressed: () {},
                ),
              ),
              _buildBottomNavItem(Icons.store, 2),
              _buildBottomNavItem(Icons.person, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSquareBox(String image, String title, String description) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            if (image.isNotEmpty) Image.asset(image, width: 36, height: 36),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (description.isNotEmpty)
              Text(description, style: const TextStyle(fontSize: 12, color: Colors.black54), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, int index) {
    final bool isSelected = _selectedIndex == index;
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? const Color(0xFF7993AE) : const Color(0xFF586C7C),
      ),
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
