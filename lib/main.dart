import 'package:flutter/material.dart';
//import 'screens/welcome_screen.dart';
import 'screens/Home_screen.dart';
//import 'screens/addProd_screen.dart';
//import 'screens/chat_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ARH App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
