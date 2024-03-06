import 'package:flutter/material.dart';
import 'package:todo_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Todo App",
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
