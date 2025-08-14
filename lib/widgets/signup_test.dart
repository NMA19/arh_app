import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignupTestWidget extends StatefulWidget {
  const SignupTestWidget({super.key});

  @override
  State<SignupTestWidget> createState() => _SignupTestWidgetState();
}

class _SignupTestWidgetState extends State<SignupTestWidget> {
  String _result = '';

  Future<void> _testSignup() async {
    setState(() {
      _result = 'Testing...';
    });

    try {
      final response = await AuthService.register(
        email: 'testuser@example.com',
        password: 'password123',
        firstName: 'Test',
        lastName: 'User',
        username: 'testuser',
      );
      
      setState(() {
        _result = 'Success: ${response.toString()}';
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _testSignup,
              child: const Text('Test Signup'),
            ),
            const SizedBox(height: 20),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
