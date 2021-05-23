import 'package:flutter/material.dart';
import 'package:mingo_app/src/screens/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mingo',
      theme: ThemeData(
        accentColor: Colors.orange,
        primaryColor: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
