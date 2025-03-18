import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart'; // Keep only necessary imports

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyLoginPage(), // Start with login page
    );
  }
}
