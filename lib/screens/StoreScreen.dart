import 'package:flutter/material.dart';
import 'BaseNavigationWidget.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _productPageController = PageController();

  List<dynamic> categories = [];
  List<dynamic> products = [];
  bool _isLoadingCategories = true;
  bool _isLoadingProducts = true;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadCategories();
    await _loadProducts();
  }

  Future<void> _loadCategories() async {
    try {
      // Mock categories data
      final categoryList = [
        {'name': 'Chairs', 'imageUrl': 'assets/images/Store/Categories/Black.png'},
        {'name': 'Sofas', 'imageUrl': 'assets/images/Store/Categories/Brown.png'},
        {'name': 'Tables', 'imageUrl': 'assets/images/Store/Categories/Chair.png'},
        {'name': 'Lighting', 'imageUrl': 'assets/images/Store/Categories/Gray.png'},
        {'name': 'Decor', 'imageUrl': 'assets/images/Store/Categories/Brown.png'},
        {'name': 'Storage', 'imageUrl': 'assets/images/Store/Categories/Black.png'},
      ];
      
      setState(() {
        categories = categoryList;
        _isLoadingCategories = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingCategories = false;
      });
      // Fallback to static categories if API fails
      categories = [
        {'name': 'Chairs', 'imageUrl': 'assets/images/Store/Categories/Black.png'},
        {'name': 'Tables', 'imageUrl': 'assets/images/Store/Categories/Black (1).png'},
        {'name': 'Sofas', 'imageUrl': 'assets/images/Store/Categories/Black (2).png'},
        {'name': 'Decor', 'imageUrl': 'assets/images/Store/Categories/Black (3).png'},
        {'name': 'Lighting', 'imageUrl': 'assets/images/Store/Categories/Black (4).png'},
      ];
    }
  }

  Future<void> _loadProducts({String? search, String? category}) async {
    try {
      setState(() {
        _isLoadingProducts = true;
      });
      
      // Mock products data
      final mockProducts = [
        {
          'id': '1',
          'name': 'Modern Armchair',
          'price': 299.99,
          'image': 'assets/images/Store/chairs/1.png',
          'rating': 4.5,
          'category': 'Chairs'
        },
        {
          'id': '2',
          'name': 'Dining Table',
          'price': 599.99,
          'image': 'assets/images/Store/tables/1.png',
          'rating': 4.8,
          'category': 'Tables'
        },
        {
          'id': '3',
          'name': 'Floor Lamp',
          'price': 129.99,
          'image': 'assets/images/Store/lighting/1.png',
          'rating': 4.2,
          'category': 'Lighting'
        },
        {
          'id': '4',
          'name': 'Velvet Sofa',
          'price': 899.99,
          'image': 'assets/images/Store/sofas/1.png',
          'rating': 4.7,
          'category': 'Sofas'
        }
      ];
      
      setState(() {
        products = mockProducts;
        _isLoadingProducts = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingProducts = false;
      });
      // Fallback to static products if API fails
      products = [
        {
          'name': 'Serene Interior Decor',
          'description': 'Comfortable armchair',
          'price': 899.99,
          'imageUrl': 'assets/images/Store/Serene Interior Decor.png',
          'category': {'name': 'Chairs'},
        },
        {
          'name': 'Orange Pillow Set',
          'description': 'Home decor pillows',
          'price': 149.99,
          'imageUrl': 'assets/images/Store/Serene Interior with Orange Pillow.png',
          'category': {'name': 'Decor'},
        },
        {
          'name': 'Warm Toned Elegance',
          'description': 'Office furniture set',
          'price': 1299.99,
          'imageUrl': 'assets/images/Store/Warm Toned Elegance_ Sophisticated Home Office.png',
          'category': {'name': 'Tables'},
        },
      ];
    }
  }

  void _onSearchChanged() {
    _loadProducts(search: _searchController.text);
  }

  void _onCategorySelected(String categoryName) {
    setState(() {
      _selectedCategory = categoryName;
    });
    _loadProducts(category: categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return BaseNavigationWidget(
      title: '',
      selectedIndex: 2,
      showSearchBar: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/icons/app_icon.png',
                  height: 100,
                  width: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7993AE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.store, color: Colors.white, size: 40),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(Icons.search, color: Colors.grey, size: 20),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) => _onSearchChanged(),
                        decoration: const InputDecoration(
                          hintText: 'Search for products...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFA75726),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.filter_list, color: Colors.white, size: 20),
                        onPressed: () => _showFilterDialog(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 100,
                    child: _isLoadingCategories
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              final backgroundColor = index == 1
                                  ? const Color(0xFFFFA167).withOpacity(0.53)
                                  : const Color(0xFFCDAF33).withOpacity(0.2);
                              return GestureDetector(
                                onTap: () => _onCategorySelected(category['name']),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: backgroundColor,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: category['imageUrl'] != null
                                            ? Image.asset(
                                                category['imageUrl'],
                                                fit: BoxFit.contain,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return const Icon(Icons.category, size: 30);
                                                },
                                              )
                                            : const Icon(Icons.category, size: 30),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        category['name'],
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Featured Products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 380,
                    child: _isLoadingProducts
                        ? const Center(child: CircularProgressIndicator())
                        : PageView.builder(
                            controller: _productPageController,
                            itemCount: products.length,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(right: 16),
                              child: _buildProductCard(products[index]),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              color: Colors.grey[100],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: product['imageUrl'] != null
                      ? Image.asset(
                          product['imageUrl'],
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 200,
                              color: Colors.grey[200],
                              child: const Icon(Icons.chair, size: 50, color: Colors.grey),
                            );
                          },
                        )
                      : Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.grey[200],
                          child: const Icon(Icons.chair, size: 50, color: Colors.grey),
                        ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.favorite_border, color: Colors.grey, size: 20),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'] ?? 'Unknown Product',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2C3E50)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['category']?['name'] ?? product['description'] ?? '',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${(product['price'] ?? 0).toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFFA75726)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA75726),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Products'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Filter by category:'),
            DropdownButton<String>(
              value: _selectedCategory,
              hint: const Text('Select Category'),
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category['name'],
                  child: Text(category['name']),
                );
              }).toList(),
              onChanged: (value) {
                Navigator.pop(context);
                if (value != null) {
                  _onCategorySelected(value);
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }
}