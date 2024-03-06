import 'package:flutter/material.dart';

class TodoInfoScreen extends StatelessWidget {
  String title;
  TodoInfoScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(title),
      ),
    );
  }
}
