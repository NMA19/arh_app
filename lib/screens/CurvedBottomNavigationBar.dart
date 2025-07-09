import 'package:flutter/material.dart';

// ----------------------------
// Reusable Curved Bottom Navigation Bar
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
      height: 110,
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
                height: 105,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildNavItem(0)),
                      Expanded(child: _buildNavItem(1)),
                      const SizedBox(width: 80),
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
            top: -20,
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
                          width: 64,
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
    path.quadraticBezierTo(w * 0.43, 45, w * 0.50, 60);
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