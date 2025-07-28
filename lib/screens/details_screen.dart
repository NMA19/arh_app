import 'package:flutter/material.dart';
import 'CurvedBottomNavigationBar.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String? expandedCategory;

  void toggleCategory(String category) {
    setState(() {
      expandedCategory = (expandedCategory == category) ? null : category;
    });
  }

  final List<String> companyDetails = [
    'Information',
    'Location',
    'Service',
    'Contacts',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Image.asset('assets/icons/app_icon.png', height: 80),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                color: const Color(0xFFD9D9D9),
                                alignment: Alignment.center,
                                child: const Text('Project Manager'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                height: 40,
                                color: const Color(0xFFD9D9D9),
                                alignment: Alignment.center,
                                child: const Text('Industry'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SizedBox.shrink(),
                            Text(
                              'See all',
                              style: TextStyle(fontSize: 14, color: Color(0xFF7993AE)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildCategoryTile('Companies', isSelected: expandedCategory == 'Companies'),
                            _buildCategoryTile('Architects', isSelected: expandedCategory == 'Architects'),
                            _buildCategoryTile('Contractors', isSelected: expandedCategory == 'Contractors'),
                          ],
                        ),

                        if (expandedCategory == 'Companies')
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
                            child: Column(
                              children: companyDetails
                                  .map((detail) => Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: const Color(0xFFD9D9D9),
                                child: ListTile(
                                  title: Text(
                                    detail,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ))
                                  .toList(),
                            ),
                          ),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CurvedBottomNavigationBar(
        selectedIndex: 3,
        onTap: (index) {},
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF7993AE),
        unselectedItemColor: Colors.grey,
        fabIcon: const Icon(Icons.search, color: Colors.white),
        fabBackgroundColor: const Color(0xFF7993AE),
        onFabPressed: () {},
        items: const [
          CurvedBottomNavigationBarItem(icon: Icons.home, label: 'Home'),
          CurvedBottomNavigationBarItem(icon: Icons.favorite, label: 'Favorites'),
          CurvedBottomNavigationBarItem(icon: Icons.store, label: 'Store'),
          CurvedBottomNavigationBarItem(icon: Icons.info, label: 'Details'),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(String label, {required bool isSelected}) {
    return Expanded(
      child: InkWell(
        onTap: () => toggleCategory(label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF483C32) : const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                isSelected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: isSelected ? Colors.white : Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
