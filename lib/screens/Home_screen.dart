import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
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
              // AppBar with logo
              Row(
                children: [
                  Image.asset('assets/icons/app_icon.png', width: 100, height: 100),
                  const SizedBox(width: 8),
                ],
              ),
              const SizedBox(height: 20),

              // Project Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  border: Border.all(color: Color(0xFF7993AE), width: 0.5),
                  borderRadius: BorderRadius.zero,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Your Project",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF586C7C),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Start Modeling your\narchitectural projects here",
                            style: TextStyle(color: Colors.black54, fontSize: 13),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF586C7C),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Start modeling",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text("Recent design", style: TextStyle(color: Colors.black87)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/images/Blueprint.png', fit: BoxFit.fitWidth, height: 100),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Store and Inspiration
              Row(
                children: [
                  _buildSquareBox('assets/images/Store.png', 'Store', 'Explore furniture & decor for your project'),
                  const SizedBox(width: 16),
                  _buildSquareBox('assets/images/Inspiration.png', 'Inspiration', 'Browse through various design ideas to fuel your creativity'),
                ],
              ),
              const SizedBox(height: 16),

              // AI Scanner, AR Viewer, Magic Plan
              Row(
                children: [
                  _buildSquareBox('assets/images/AI scanner.png', 'AI scanner', ''),
                  const SizedBox(width: 16),
                  _buildSquareBox('assets/images/AR viewer.png', 'AR viewer', ''),
                  const SizedBox(width: 16),
                  _buildSquareBox('assets/images/Magic plan.png', 'Magic plan', ''),
                ],
              ),
              const SizedBox(height: 16),

              // LoadEas & SOS
              Row(
                children: [
                  _buildSquareBox('assets/images/Blueprint.png', 'LoadEas', ''),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 36, bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/Sos.png',
                          width: 60,
                          height: 60,
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

      // Curved Bottom Navigation Bar
      bottomNavigationBar: CurvedBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _animationController.reset();
          _animationController.forward();
        },
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
        unselectedItemColor: Colors.black54,
        fabIcon: Image.asset('assets/icons/Search.png', width: 26, height: 26),
        fabBackgroundColor: const Color(0xFFDED2C8),
        onFabPressed: () {},
      ),
    );
  }

  Widget _buildSquareBox(String image, String title, String description) {
    return Expanded(
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
    );
  }
}

// Custom Curved Bottom Navigation Bar
class CurvedBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final List<CurvedBottomNavigationBarItem> items;
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Widget fabIcon;
  final Color fabBackgroundColor;
  final VoidCallback onFabPressed;

  const CurvedBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor = Colors.white,
    this.selectedItemColor = Colors.blue,
    this.unselectedItemColor = Colors.grey,
    required this.fabIcon,
    this.fabBackgroundColor = Colors.blue,
    required this.onFabPressed,
  });

  @override
  State<CurvedBottomNavigationBar> createState() => _CurvedBottomNavigationBarState();
}

class _CurvedBottomNavigationBarState extends State<CurvedBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ClipPath(
            clipper: CurvedBottomClipper(),
            child: Container(
              color: widget.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < widget.items.length; i++)
                    if (i == widget.items.length ~/ 2)
                      const SizedBox(width: 60) // Space for FAB
                    else
                      _buildNavItem(i),
                ],
              ),
            ),
          ),
        ),

        // Floating Action Button
        Positioned(
          top: -25,
          child: GestureDetector(
            onTapDown: (_) {
              _animationController.reverse();
            },
            onTapUp: (_) {
              _animationController.forward();
              widget.onFabPressed();
            },
            onTapCancel: () {
              _animationController.forward();
            },
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: widget.fabBackgroundColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(child: widget.fabIcon),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected = widget.selectedIndex == index;
    final item = widget.items[index];

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? widget.selectedItemColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                item.icon,
                color: isSelected ? widget.selectedItemColor : widget.unselectedItemColor,
                size: isSelected ? 28 : 24,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: isSelected ? widget.selectedItemColor : widget.unselectedItemColor,
                fontSize: isSelected ? 12 : 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom clipper for curved bottom navigation
class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(0, 20);
    path.quadraticBezierTo(0, 0, 20, 0);
    path.lineTo(w * 0.35, 0);
    path.quadraticBezierTo(w * 0.4, 0, w * 0.4, 10);
    path.arcToPoint(
      Offset(w * 0.6, 10),
      radius: const Radius.circular(35),
      clockwise: false,
    );
    path.quadraticBezierTo(w * 0.6, 0, w * 0.65, 0);
    path.lineTo(w - 20, 0);
    path.quadraticBezierTo(w, 0, w, 20);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Data class for navigation items
class CurvedBottomNavigationBarItem {
  final IconData icon;
  final String label;

  const CurvedBottomNavigationBarItem({
    required this.icon,
    required this.label,
  });
}