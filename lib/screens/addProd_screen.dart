import 'package:flutter/material.dart';

class AddProdScreen extends StatefulWidget {
  const AddProdScreen({super.key});

  @override
  State<AddProdScreen> createState() => _AddProdScreenState();
}

class _AddProdScreenState extends State<AddProdScreen> {
  String? selectedCategory;
  String? selectedColor;
  String? selectedBrand;
  String? selectedAR;

  final List<String> categories = ['Furniture', 'Lighting', 'Decor'];
  final List<String> colors = ['Red', 'Blue', 'Green'];
  final List<String> brands = ['Brand A', 'Brand B', 'Brand C'];
  final List<String> arInputs = ['Model 1', 'Model 2', 'Model 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/icons/app_icon.png', height: 80),
              const SizedBox(height: 16),
              const Text(
                'Add Product',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF586C7C),
                ),
              ),
              const SizedBox(height: 24),
              _buildLabel('Product name ', isRequired: true),
              _buildTextField(hint: 'Enter product name'),
              const SizedBox(height: 8),
              const Text(
                'Do not exceed 20 characters when entering the product name.',
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdownField('Category', categories, selectedCategory, (val) => setState(() => selectedCategory = val), isRequired: true),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDropdownField('Color', colors, selectedColor, (val) => setState(() => selectedColor = val), isRequired: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdownField('Brand', brands, selectedBrand, (val) => setState(() => selectedBrand = val), isRequired: true),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDropdownField('Input AR', arInputs, selectedAR, (val) => setState(() => selectedAR = val), isRequired: true),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildLabel('Description ', isRequired: true),
              _buildTextField(
                hint: 'Enter product description',
                maxLines: 5,
              ),
              const SizedBox(height: 8),
              const Text(
                'Do not exceed 100 characters when entering the product name.',
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF586C7C),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Add Product',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF586C7C),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Color(0xFF586C7C)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Save Product'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {bool isRequired = false}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        children: isRequired
            ? const [
          TextSpan(
            text: '*',
            style: TextStyle(color: Colors.red),
          ),
        ]
            : [],
      ),
    );
  }

  Widget _buildTextField({required String hint, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF586C7C), width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, String? selectedValue, ValueChanged<String?> onChanged, {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, isRequired: isRequired),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          isExpanded: true,
          value: selectedValue,
          hint: Text('Select $label'),
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF586C7C), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
