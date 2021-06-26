import 'package:contact_tracing/ui/screens/loader.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Loader());
  }
}
