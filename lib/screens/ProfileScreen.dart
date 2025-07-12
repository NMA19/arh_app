import 'package:flutter/material.dart';
import 'BaseNavigationWidget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseNavigationWidget(
      title: '',
      selectedIndex: 3,
      showSearchBar: false,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDED2C8),
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF586C7C),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SettingItem(title: 'Account Settings', icon: Icons.person, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountSettingsForm()),
              );
            }),
            const Divider(thickness: 1, color: Colors.grey),
            const SettingItem(title: 'Payment', icon: Icons.payment),
            const Divider(thickness: 1, color: Colors.grey),
            const SettingItem(title: 'Notification', icon: Icons.notifications),
            const Divider(thickness: 1, color: Colors.grey),
            const SettingItem(title: 'Security', icon: Icons.lock),
            const Divider(thickness: 1, color: Colors.grey),
            const SettingItem(title: 'Language', icon: Icons.language),
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const SettingItem({required this.title, required this.icon, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Color(0xFF586C7C)),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class AccountSettingsForm extends StatelessWidget {
  const AccountSettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDED2C8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDED2C8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Account Settings', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Name')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Surname')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Age')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Profession')),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Region')),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7993AE),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Handle form submission
                },
                child: const Text('Register', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
