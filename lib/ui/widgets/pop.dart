import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showPop(BuildContext context,
    {String title, Widget content, VoidCallback action, String actionLabel}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('$title'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: SingleChildScrollView(child: content),
            actions: [
              TextButton(
                  onPressed: () {
                    action();
                  },
                  child: Text('$actionLabel')),
              TextButton(
                  onPressed: () => UserNavigation.pop(context),
                  child: Text('Close'))
            ],
          ));
}
