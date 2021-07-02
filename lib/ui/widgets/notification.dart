import 'package:flutter/material.dart';

void showSnack(BuildContext context, {String content, bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: error ? Colors.redAccent : null,
    content: Text(
      '$content',
      style: TextStyle(color: error ? Colors.white : null),
    ),
  ));
}
