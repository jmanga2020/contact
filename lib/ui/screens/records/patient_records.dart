import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_tracing/services/metrics/deviceMetrics.dart';
import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/services/utils/shared.dart';
import 'package:contact_tracing/ui/screens/animation/loaders.dart';
import 'package:contact_tracing/ui/screens/home.dart';
import 'package:contact_tracing/ui/screens/records/details.dart';
import 'package:contact_tracing/ui/widgets/bottom.dart';
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
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  icon: Icon(Icons.sort),
                  onPressed: () {
                    bottomSheet(
                        context,
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 15.0,
                                  bottom:
                                      DeviceMetrics.deviceHeight(context) / 20,
                                  left: 0,
                                  right: 0),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Records')
                                      .where('status', isEqualTo: 'Positive')
                                      .snapshots(),
                                  builder:
                                      (_, AsyncSnapshot<QuerySnapshot> snap) {
                                    if (snap.hasData) {
                                      return ListView.separated(
                                          itemCount: snap.data.docs.length,
                                          separatorBuilder: (_, i) => Divider(),
                                          itemBuilder: (_, i) => ListTile(
                                                title: Text(
                                                    '${snap.data.docs[i]['sex']}  -  ${snap.data.docs[i]['age']} years old'),
                                                subtitle: Text(
                                                    '${snap.data.docs[i]['location']}'),
                                                leading: CircleAvatar(
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    ),
                                                    backgroundColor:
                                                        Colors.red),
                                              ));
                                    } else if (snap.connectionState ==
                                        ConnectionState.waiting) {
                                      return UniversalLoader(
                                        label: 'Loading ...',
                                      );
                                    } else {
                                      return Center(
                                          child: Text('Error Occured'));
                                    }
                                  }),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height:
                                    DeviceMetrics.deviceHeight(context) / 20,
                                color: Colors.teal,
                                width: DeviceMetrics.deviceWidth(context),
                                child: OutlinedButton(
                                    onPressed: () {},
                                    child: Center(
                                        child: Text(
                                      'SEND DATA',
                                      style: TextStyle(color: Colors.white),
                                    ))),
                              ),
                            )
                          ],
                        ));
                  }),
              IconButton(
                  tooltip: 'LogOut',
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                    showPop(context, title: 'Log Out', action: () {
                      TempMemory.remove(key: 'admin');
                      UserNavigation.push(context, destination: Home());
                      showSnack(context, content: 'You are logged out');
                    },
                        actionLabel: 'Log Out',
                        content: Text(
                            'You are about to Log Out of the application.'));
                  })
            ],
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                UserNavigation.push(context, destination: PatientDetails());
              }),
          body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Records').snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snap) {
                if (snap.hasData) {
                  return ListView.separated(
                      itemCount: snap.data.docs.length,
                      separatorBuilder: (_, i) => Divider(),
                      itemBuilder: (_, i) => ListTile(
                            onTap: () {
                              bottomSheet(
                                  context,
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              'Sex',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                                '${snap.data.docs[i]['sex']}'),
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text(
                                              'Age',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                                '${snap.data.docs[i]['age']}'),
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text(
                                              'Location',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                                '${snap.data.docs[i]['location']}'),
                                          ),
                                          Divider(),
                                          ListTile(
                                            title: Text(
                                              'Covid Status',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            trailing: CircleAvatar(
                                              backgroundColor: snap.data.docs[i]
                                                          ['status'] !=
                                                      'Negative'
                                                  ? Colors.red
                                                  : Colors.teal,
                                            ),
                                            subtitle: Text(
                                                '${snap.data.docs[i]['status']}'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                            title: Text(
                                '${snap.data.docs[i]['sex']}  -  ${snap.data.docs[i]['age']} years old'),
                            subtitle: Text('${snap.data.docs[i]['location']}'),
                            leading: CircleAvatar(
                              child: Icon(
                                snap.data.docs[i]['status'] == 'Negative'
                                    ? Icons.done_all
                                    : Icons.close,
                                color: Colors.white,
                              ),
                              backgroundColor:
                                  snap.data.docs[i]['status'] != 'Negative'
                                      ? Colors.red
                                      : Colors.teal,
                            ),
                          ));
                } else if (snap.connectionState == ConnectionState.waiting) {
                  return UniversalLoader(
                    label: 'Loading ...',
                  );
                } else {
                  return Center(child: Text('Error Occured'));
                }
              })),
    );
  }
}
