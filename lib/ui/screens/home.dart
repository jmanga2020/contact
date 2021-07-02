import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/ui/screens/tabs/homePage.dart';
import 'package:contact_tracing/ui/screens/tabs/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  Widget _switcher(int i) {
    switch (i) {
      case 0:
        return HomeScreen();
        break;
      case 1:
        return Settings();
        break;
      default:
        return HomeScreen();
        break;
    }
  }

  Future<bool> _exit() async {
    bool _ret = false;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('EXIT APP'),
              content: SingleChildScrollView(
                child: Text('You are about to exit .....'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      UserNavigation.pop(context);
                      setState(() {
                        _ret = false;
                      });
                    },
                    child: Text('Close')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _ret = true;
                      });
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    child: Text('Exit')),
              ],
            ));
    return _ret;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exit(),
      child: Scaffold(
        body: _switcher(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (i) => setState(() {
                  _currentIndex = i;
                }),
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: 'Settings', icon: Icon(Icons.settings))
            ]),
      ),
    );
  }
}
