import 'package:flutter/material.dart';
import 'signup_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isSignUpSelected = false;
  bool _obscurePassword = true; // 👁️ Toggle for password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF586C7C),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 35),
              const Center(
                child: Text(
                  'MyApp Name',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Switcher
              Container(
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignUpSelected = true;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SignUpScreen()),
                          ).then((_) {
                            // When user returns from SignUp screen
                            setState(() {
                              isSignUpSelected = false;
                            });
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: isSignUpSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: isSignUpSelected ? const Color(0xFF586C7C) : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignUpSelected = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: !isSignUpSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: !isSignUpSelected ? const Color(0xFF586C7C) : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 34),

              // Email
              const TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Password with Eye Icon
              TextField(
                obscureText: _obscurePassword,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[700],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDED2C8),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Handle Sign In
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Color(0xFF586C7C),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 48),

              const Center(
                child: Text(
                  'Other sign in options',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 20),

              // Social icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/facebook.png',
                    width: 36,
                    height: 36,
                  ),
                  const SizedBox(width: 30),
                  Image.asset(
                    'assets/icons/google.png',
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(width: 30),
                  Image.asset(
                    'assets/icons/apple.png',
                    width: 38,
                    height: 38,
                  ),
                ],
              ),
              const SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }
}
