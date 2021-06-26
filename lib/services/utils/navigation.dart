import 'package:flutter/material.dart';

class UserNavigation {
  static void push(BuildContext context, {@required Widget destination}) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => destination));
  }

  static void pushReplace(BuildContext context, {@required Widget destination}) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => destination));
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
