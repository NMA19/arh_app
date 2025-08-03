import 'package:flutter/material.dart';
import 'CurvedBottomNavigationBar.dart';
import 'Home_screen.dart';
import 'FavoritesScreen.dart';
import 'StoreScreen.dart';
import 'details_screen.dart';
import '';

class BaseNavigationWidget extends StatefulWidget {
  final Widget child;
  final String title;
  final int selectedIndex;
  final bool showSearchBar;

  const BaseNavigationWidget({
    super.key,
    required this.child,
    required this.title,
    required this.selectedIndex,
    this.showSearchBar = true,
  });

  @override
  State<BaseNavigationWidget> createState() => _BaseNavigationWidgetState();
}

class _BaseNavigationWidgetState extends State<BaseNavigationWidget> {
  final TextEditingController _searchController = TextEditingController();

  void _onNavItemTapped(int index) {
    if (index == widget.selectedIndex) return; // Don't navigate to same page

    Widget destination;
    switch (index) {
      case 0:
        destination = const HomeScreen();
        break;
      case 1:
        destination = const FavoritesScreen();
        break;
      case 2:
        destination = const StoreScreen();
        break;
      case 3:
        destination = const DetailsScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  void _onSearchPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search'),
          content: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Enter search term...',
              prefixIcon: Icon(Icons.search),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _searchController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement search logic here
                print('Searching for: ${_searchController.text}');
                Navigator.of(context).pop();
                _searchController.clear();
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      appBar: widget.title.isNotEmpty
          ? AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF7993AE),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: widget.showSearchBar
            ? [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSearchPressed,
          ),
        ]
            : null, // Remove search icon when showSearchBar is false
      )
          : null, // Remove AppBar completely when title is empty
      body: SafeArea(
        child: Column(
          children: [
            // Only show search bar if showSearchBar is true
            if (widget.showSearchBar)
              Container(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search architecture...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF7993AE)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Color(0xFF7993AE)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Color(0xFF7993AE), width: 2.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      print('Searching for: $value');
                      // Implement search logic here
                    }
                  },
                ),
              ),
            Expanded(
              child: widget.child,
            ),
            const SizedBox(height: 80), // Room for curved nav bar
          ],
        ),
      ),
      bottomNavigationBar: CurvedBottomNavigationBar(
        selectedIndex: widget.selectedIndex,
        onTap: _onNavItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF7993AE),
        unselectedItemColor: Colors.grey,
        fabIcon: const Icon(Icons.search, color: Colors.white), // Changed to always show search icon
        fabBackgroundColor: const Color(0xFF7993AE),
        onFabPressed: _onSearchPressed, // Always use search function
        items: const [
          CurvedBottomNavigationBarItem(icon: Icons.home, label: 'Home'),
          CurvedBottomNavigationBarItem(
              icon: Icons.favorite, label: 'Favorites'),
          CurvedBottomNavigationBarItem(icon: Icons.store, label: 'Store'),
          CurvedBottomNavigationBarItem(icon: Icons.info_outline, label: 'Details'),
        ],
      ),
    );
  }
}