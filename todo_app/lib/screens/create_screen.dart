import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({super.key});
  String title = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Todo"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              onChanged: (value) {
                title = value;
              },
              decoration: InputDecoration(
                label: Text("Title"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, title);
              },
              child: Text("Create"),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(30)),
            )
          ],
        ),
      ),
    );
  }
}
