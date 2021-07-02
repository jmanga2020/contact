import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/services/utils/shared.dart';
import 'package:contact_tracing/ui/screens/homeScreen.dart';
import 'package:contact_tracing/ui/screens/records/details.dart';
import 'package:contact_tracing/ui/widgets/notification.dart';
import 'package:contact_tracing/ui/widgets/pop.dart';
import 'package:flutter/material.dart';

class PatientRecords extends StatefulWidget {
  @override
  _PatientRecordsState createState() => _PatientRecordsState();
}

class _PatientRecordsState extends State<PatientRecords> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Patients Records'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                tooltip: 'LogOut',
                icon: Icon(Icons.exit_to_app),
                onPressed: () async {
                  showPop(context, title: 'Log Out', action: () {
                    TempMemory.remove(key: 'admin');
                    UserNavigation.push(context, destination: HomeScreen());
                    showSnack(context, content: 'You are logged out');
                  },
                      actionLabel: 'Log Out',
                      content:
                          Text('You are about to Log Out of the application.'));
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              UserNavigation.push(context, destination: PatientDetails());
            }),
        body: Text('H'),
      ),
    );
  }
}
