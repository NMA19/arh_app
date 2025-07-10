import 'package:flutter/material.dart';
import 'BaseNavigationWidget.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseNavigationWidget(
      title: 'Store',
      selectedIndex: 2,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.store, size: 80, color: Color(0xFF7993AE)),
            SizedBox(height: 16),
            Text(
              'Architecture Store',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Browse and purchase architecture materials',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}