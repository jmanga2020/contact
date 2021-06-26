import 'package:flutter/material.dart';
import 'package:contact_tracing/screens/onBoarding Screen.dart';

import 'screens/loader.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Loader());
  }
}
