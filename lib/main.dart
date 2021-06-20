import 'package:contact_tracing/screens/homsScreen.dart';
import 'package:contact_tracing/screens/auth/logiScreen.dart';
import 'package:flutter/material.dart';
import 'package:contact_tracing/screens/auth/register_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        '/loginScreen': (context) => LoginScreen(),
        '/registerScreen': (context) => RegisterScreen(),
      },
    );
  }
}
