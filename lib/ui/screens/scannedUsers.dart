import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScannedUser extends StatelessWidget {
  final String userId;
  ScannedUser({this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner Results'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Records')
              .where('id', isEqualTo: userId)
              .snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snap) {
            if (snap.hasData && snap.data.docs.length != 0) {
              var _data = snap.data.docs[0];
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                     ListTile(
                      leading: Icon(FontAwesomeIcons.venusMars),
                      title: Text("Sex: ${_data['sex']}"),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.mapMarkerAlt),
                      title: Text("Location: ${_data['location']}"),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.child),
                      title: Text("Age: ${_data['age']}"),
                    ),
                    Divider(),
                    ListTile(
                      tileColor: _data['status'] == 'Positive'
                          ? Colors.redAccent
                          : Colors.teal,
                      leading: Icon(FontAwesomeIcons.viruses),
                      title: Text(
                        "Patient Status:  ${_data['status'] == 'Positive' ? 'INFECTED' : 'NOT INFECTED'}",
                        style: TextStyle(
                            color: _data['status'] == 'Positive'
                                ? Colors.white
                                : null),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('Sorry No records found!!'),
              );
            }
          }),
    );
  }
}
