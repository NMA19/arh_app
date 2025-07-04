import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF586C7C),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 🔙 Back Arrow in Transparent Box with White Border + Title below
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 42),

                // 🧑 Username
                _buildInput("Username"),
                const SizedBox(height: 16),

                // 📧 Email
                _buildInput("Email", keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16),

                // 🔒 Password
                _buildPasswordField("Password", true),
                const SizedBox(height: 16),

                // 🔒 Confirm Password
                _buildPasswordField("Confirm Password", false),
                const SizedBox(height: 16),

                // ✅ Checkbox
                CheckboxListTile(
                  activeColor: Colors.white,
                  checkColor: Colors.black,
                  title: const Text(
                    "I accept the terms and privacy policy",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  value: _acceptTerms,
                  onChanged: (value) {
                    setState(() => _acceptTerms = value ?? false);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 24),

                // 🔘 Sign Up Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD9C9BB),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _acceptTerms) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Signing up...")),
                      );
                    }
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to Login screen if needed
                    },
                    child: const Text(
                      "Already have an account? Log in",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🧩 Input Field Builder
  Widget _buildInput(String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) =>
      value == null || value.isEmpty ? "Please enter $label" : null,
    );
  }

  // 🧩 Password Field Builder
  Widget _buildPasswordField(String label, bool isPassword) {
    return TextFormField(
      obscureText: isPassword ? _obscurePassword : _obscureConfirm,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            (isPassword ? _obscurePassword : _obscureConfirm)
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.grey[700],
          ),
          onPressed: () {
            setState(() {
              if (isPassword) {
                _obscurePassword = !_obscurePassword;
              } else {
                _obscureConfirm = !_obscureConfirm;
              }
            });
          },
        ),
      ),
      validator: (value) => value == null || value.length < 8
          ? "Password must be at least 8 characters"
          : null,
    );
  }
}
