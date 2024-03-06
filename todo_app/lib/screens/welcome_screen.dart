import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/todos_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String _rollNo = "";
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 120,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image.asset("images/logo.png"),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  onChanged: (value) {
                    _rollNo = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "Enter Your Roll No",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                    onPressed: () async {
                      if (_rollNo.trim().isEmpty) return;

                      final sharedPreference =
                          await SharedPreferences.getInstance();
                      sharedPreference.setString("rollNo", _rollNo.trim());

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (con) => TodoScreen()));
                    },
                    tooltip: "Continue",
                    icon: const Icon(
                      Icons.arrow_circle_right_rounded,
                      size: 50,
                      color: Colors.blue,
                    ))
              ],
            )),
      ),
    );
  }
}
