import 'dart:ui';
import 'package:flutter/material.dart';
import 'Home_screen.dart';
import 'FavoritesScreen.dart';
import 'StoreScreen.dart';
import 'details_screen.dart';
import 'discober_screen.dart';

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
  State<CurvedBottomNavigationBar> createState() =>
      _CurvedBottomNavigationBarState();
}

class _CurvedBottomNavigationBarState extends State<CurvedBottomNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController _fabAnimationController;
  late AnimationController _rippleAnimationController;
  late Animation<double> _fabScaleAnimation;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _rippleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fabScaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeInOut),
    );

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleAnimationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _rippleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 97,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ✅ CARD-STYLE NAVBAR (No ClipPath)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: _buildNavItem(0)),
                        Expanded(child: _buildNavItem(1)),
                        const SizedBox(width: 56),
                        Expanded(child: _buildNavItem(2)),
                        Expanded(child: _buildNavItem(3)),
                      ],
                    ),
                  ),

                  // Fake circular cutout to simulate FAB notch
                  Positioned(
                    top: -28,
                    left: (MediaQuery.of(context).size.width - 30) / 2 - 16,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: widget.backgroundColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ✅ FAB
          Positioned(
            top: -28,
            left: (MediaQuery.of(context).size.width - 70) / 2,
            child: GestureDetector(
              onTapDown: (_) => _fabAnimationController.forward(),
              onTapUp: (_) {
                _fabAnimationController.reverse();
                _rippleAnimationController.forward().then((_) {
                  _rippleAnimationController.reset();
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DiscoverScreen()),
                );
              },
              onTapCancel: () => _fabAnimationController.reverse(),
              child: AnimatedBuilder(
                animation:
                Listenable.merge([_fabScaleAnimation, _rippleAnimation]),
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_rippleAnimation.value > 0)
                        Container(
                          width: 56 + (_rippleAnimation.value * 20),
                          height: 56 + (_rippleAnimation.value * 20),
                          decoration: BoxDecoration(
                            color: widget.fabBackgroundColor
                                .withOpacity(0.3 * (1 - _rippleAnimation.value)),
                            shape: BoxShape.circle,
                          ),
                        ),
                      Transform.scale(
                        scale: _fabScaleAnimation.value,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: widget.fabBackgroundColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color:
                                widget.fabBackgroundColor.withOpacity(0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
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
      onTap: () {
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
              MaterialPageRoute(builder: (context) => const DetailsScreen()),
            );
            break;
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item.icon,
            color: isSelected
                ? widget.selectedItemColor
                : widget.unselectedItemColor,
            size: isSelected ? 24 : 22,
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 20 : 0,
            height: 3,
            decoration: BoxDecoration(
              color: widget.selectedItemColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedBottomNavigationBarItem {
  final IconData icon;
  final String label;

  const CurvedBottomNavigationBarItem({
    required this.icon,
    required this.label,
  });
}
