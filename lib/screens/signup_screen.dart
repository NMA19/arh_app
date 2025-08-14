import 'package:flutter/material.dart';
import 'login_screen.dart'; // ✅ Correct import for the login page
import '../services/auth_service.dart';
import 'Home_screen.dart';

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
  bool _isLoading = false;
  
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept the terms to continue.")),
      );
      return;
    }
    
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await AuthService.register(
        email: _emailController.text,
        password: _passwordController.text,
        firstName: _usernameController.text.split(' ').first,
        lastName: _usernameController.text.split(' ').length > 1 
            ? _usernameController.text.split(' ').last 
            : '',
        username: _usernameController.text,
      );
      
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
                // 🔙 Back Arrow and Title
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

                // Username
                _buildInput("Username", _usernameController),
                const SizedBox(height: 16),

                // Email
                _buildInput("Email", _emailController, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16),

                // Password
                _buildPasswordField("Password", _passwordController, true),
                const SizedBox(height: 16),

                // Confirm Password
                _buildPasswordField("Confirm Password", _confirmPasswordController, false),
                const SizedBox(height: 16),

                // Terms Checkbox
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

                // Sign Up Button ➜ handle validation
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD9C9BB),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading ? null : _handleSignUp,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                ),

                const SizedBox(height: 16),

                // Log in Link ➜ now navigates to LoginScreen
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "Log in",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildInput(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
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

  Widget _buildPasswordField(String label, TextEditingController controller, bool isPassword) {
    return TextFormField(
      controller: controller,
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
