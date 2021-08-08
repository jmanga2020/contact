import 'package:contact_tracing/notifications/notification.dart';
import 'package:contact_tracing/services/cloud/operations.dart';
import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/ui/screens/regions.dart';
import 'package:contact_tracing/ui/screens/tabs/homePage.dart';
import 'package:contact_tracing/ui/screens/tabs/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

String notificationId = '';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String deviceAddress;

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
  void initState() {
    FlutterBluetoothSerial.instance.address.then((address) {
      setState(() {
        deviceAddress = address;
      });
    });
    CloudNotifications.initNotifications();
    _getNotificationId().whenComplete(() async {
      if (notificationId.isNotEmpty) {
        CloudOperations.addToCloud(
            serverPath: "Notifications/$notificationId",
            data: {
              'id': notificationId,
              'bt': deviceAddress,
              'region': chosenRegion
            });
      }
    });
    super.initState();
  }

  Future<void> _getNotificationId() async {
    await CloudNotifications.subscribeUser(true);
    await CloudNotifications.acceptNotification(accepted: true);
    await CloudNotifications.getSubscriberId().then((value) {
      setState(() {
        notificationId = value;
      });
    });
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
