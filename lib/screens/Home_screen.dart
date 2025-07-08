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
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
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
        onFabPressed: () {
          // Add your Search logic here
          print('Search pressed');
        },
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

// ----------------------------
// Enhanced Curved Bottom Navigation Bar
// ----------------------------
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
    with TickerProviderStateMixin {
  AnimationController? _fabAnimationController;
  AnimationController? _rippleAnimationController;
  Animation<double>? _fabScaleAnimation;
  Animation<double>? _rippleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers first
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _rippleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Initialize animations after controllers
    _fabScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _fabAnimationController!,
      curve: Curves.easeInOut,
    ));

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rippleAnimationController!,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _fabAnimationController?.dispose();
    _rippleAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90, // Increased height to accommodate higher nav items
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom bar background with enhanced curve
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: CurvedBottomClipper(),
              child: Container(
                height: 85,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 8, right: 8), // Moved nav items to the very top
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildNavItem(0)),
                      Expanded(child: _buildNavItem(1)),
                      const SizedBox(width: 80), // Increased space for even deeper FAB curve
                      Expanded(child: _buildNavItem(2)),
                      Expanded(child: _buildNavItem(3)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Enhanced Floating Action Button with deeper curve positioning
          Positioned(
            top: -30, // Positioned even higher to create more dramatic curve effect
            left: (MediaQuery.of(context).size.width - 64) / 2,
            child: GestureDetector(
              onTapDown: (_) {
                _fabAnimationController?.forward();
              },
              onTapUp: (_) {
                _fabAnimationController?.reverse();
                _rippleAnimationController?.forward().then((_) {
                  _rippleAnimationController?.reset();
                });
                widget.onFabPressed();
              },
              onTapCancel: () {
                _fabAnimationController?.reverse();
              },
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _fabScaleAnimation ?? const AlwaysStoppedAnimation(1.0),
                  _rippleAnimation ?? const AlwaysStoppedAnimation(0.0)
                ]),
                builder: (context, child) {
                  final scaleValue = _fabScaleAnimation?.value ?? 1.0;
                  final rippleValue = _rippleAnimation?.value ?? 0.0;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // Enhanced ripple effect
                      if (rippleValue > 0)
                        Container(
                          width: 64 + (rippleValue * 30),
                          height: 64 + (rippleValue * 30),
                          decoration: BoxDecoration(
                            color: widget.fabBackgroundColor.withOpacity(0.3 * (1 - rippleValue)),
                            shape: BoxShape.circle,
                          ),
                        ),
                      // Enhanced FAB with larger size
                      Transform.scale(
                        scale: scaleValue,
                        child: Container(
                          width: 64, // Increased size
                          height: 64,
                          decoration: BoxDecoration(
                            color: widget.fabBackgroundColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: widget.fabBackgroundColor.withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                                spreadRadius: 0,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Center(child: widget.fabIcon),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected = widget.selectedIndex == index;
    final item = widget.items[index];

    return GestureDetector(
      onTap: () => widget.onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with selection indicator
            Stack(
              alignment: Alignment.center,
              children: [
                // Selection background
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: isSelected ? 28 : 0,
                  height: isSelected ? 28 : 0,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? widget.selectedItemColor.withOpacity(0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                // Icon
                Icon(
                  item.icon,
                  color: isSelected ? widget.selectedItemColor : widget.unselectedItemColor,
                  size: isSelected ? 22 : 20,
                ),
              ],
            ),
            const SizedBox(height: 2),
            // Label
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                color: isSelected ? widget.selectedItemColor : widget.unselectedItemColor,
                fontSize: isSelected ? 10 : 9,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                height: 1.2,
              ),
              child: Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Selection indicator dot
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(top: 1),
              width: isSelected ? 3 : 0,
              height: isSelected ? 3 : 0,
              decoration: BoxDecoration(
                color: widget.selectedItemColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Enhanced Clipper for deeper FAB curve
class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Start from top-left corner with rounded corner
    path.moveTo(0, 15);
    path.quadraticBezierTo(0, 0, 15, 0);

    // Left side approaching the curve
    path.lineTo(w * 0.32, 0);
    path.quadraticBezierTo(w * 0.38, 0, w * 0.40, 12);

    // Enhanced curve for FAB - much deeper and more pronounced
    path.quadraticBezierTo(w * 0.43, 45, w * 0.50, 60); // Much deeper curve
    path.quadraticBezierTo(w * 0.57, 45, w * 0.60, 12);

    // Right side leaving the curve
    path.quadraticBezierTo(w * 0.62, 0, w * 0.68, 0);
    path.lineTo(w - 15, 0);

    // Top-right corner with rounded corner
    path.quadraticBezierTo(w, 0, w, 15);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Nav Item model
class CurvedBottomNavigationBarItem {
  final IconData icon;
  final String label;

  const CurvedBottomNavigationBarItem({
    required this.icon,
    required this.label,
  });
}