import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_tracing/models/patientModel.dart';
import 'package:contact_tracing/notifications/notification.dart';
import 'package:contact_tracing/services/cloud/operations.dart';
import 'package:contact_tracing/services/metrics/deviceMetrics.dart';
import 'package:contact_tracing/services/constants/variables.dart';
import 'package:contact_tracing/ui/screens/animation/loaders.dart';
import 'package:contact_tracing/ui/widgets/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:uuid/uuid.dart';

import '../regions.dart';

class PatientDetails extends StatefulWidget {
  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  @override
  void initState() {
    _getNotificationIds();
    super.initState();
  }

  List<String> _notificationIds = [];

  Future<void> _getNotificationIds() async {
    FirebaseFirestore.instance.collection('Notifications').get().then((value) {
      if (value != null) {
        for (var i in value.docs) {
          Map<String, dynamic> _data = i.data();
          if (_data['region'] == chosenRegion) {
            _notificationIds.add(_data['id']);
          }
        }
      }
    });
  }

  String _id, _age, _sex, _location, _status;
  TextEditingController _ageController = TextEditingController();
  List<String> _sexList = ['Male', 'Female'];
  List<String> _statusList = ['Positive', 'Negative'];
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _scanning = false;



  Widget _bluetoothDevices({bool enabled = false}) {
    return ElevatedButton(
      child: Text(enabled ? 'Find Patient Device' : 'Power ON Bluetooth'),
      onPressed: !enabled || _scanning
          ? null
          : () async {
              setState(() {
                _scanning = true;
              });
              await blue
                  .startScan(timeout: Duration(seconds: 4));
              blue.connectedDevices
                  .then((value) => print(value));
              setState(() {
                _scanning = false;
              });
            },
    );
  }

  Future<void> _notify(i)async{
        await CloudNotifications.sendNotification(
                                    userIds: [i],
                                    title: 'Covid Patient',
                                    sub: 'New user affected in  $chosenRegion',
                                    body: 'Click for more description');
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? UniversalLoader(
            label: 'Submitting details, Please wait...',
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Patient Details'),
              centerTitle: true,
            ),
            bottomNavigationBar: BottomAppBar(
              child: SizedBox(
                height: 50,
                width: DeviceMetrics.deviceWidth(context),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: OutlinedButton(
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                            letterSpacing: 2, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          _formKey.currentState.save();
                          try {
                            await CloudOperations.addToCloud(
                                serverPath: 'Records/${_id ?? Uuid().v4()}',
                                data: PatientModel(
                                        //TODO:put BT id here
                                        id: _id ?? Uuid().v4(),
                                        age: _age,
                                        sex: _sex,
                                        location: _location,
                                        status: _status)
                                    .toMap());
                            if (_status == 'Positive') {
                              for (var i in _notificationIds) {
                                try{
                                  _notify(i);
                                }catch(e){
                                  _notify(i);
                                }
                              }
                            }
                            setState(() {
                              _ageController.clear();
                              _sex = null;
                              _status = null;
                              _location = null;
                              _loading = false;
                            });
                            showSnack(context,
                                content: 'Patient Details submitted');
                          } catch (e) {
                            showSnack(context,
                                error: true, content: 'Please try again later');
                          }
                        }
                      }),
                ),
              ),
            ),
            body: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        StreamBuilder(
                            stream: blue.state,
                            initialData: BluetoothState.unknown,
                            builder: (c, snapshot) {
                              final state = snapshot.data;
                              if (state == BluetoothState.on) {
                                return _bluetoothDevices(enabled: true);
                              } else {
                                return _bluetoothDevices(enabled: false);
                              }
                            }),
                        Container(
                          color: Colors.red,
                          width: DeviceMetrics.deviceWidth(context),
                          height: DeviceMetrics.deviceHeight(context) / 15,
                          child: SingleChildScrollView(
                            child: StreamBuilder<List<BluetoothDevice>>(
                                stream: Stream.periodic(Duration(seconds: 2))
                                    .asyncMap((_) =>
                                        blue.connectedDevices),
                                initialData: [],
                                builder: (c, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data.length != 0) {
                                    return Column(
                                      children: snapshot.data
                                          .map((d) => ListTile(
                                                title: Text(d.name),
                                                subtitle: Text(d.id.toString()),
                                                trailing: StreamBuilder<
                                                    BluetoothDeviceState>(
                                                  stream: d.state,
                                                  initialData:
                                                      BluetoothDeviceState
                                                          .disconnected,
                                                  builder: (c, snapshot) {
                                                    if (snapshot.data ==
                                                        BluetoothDeviceState
                                                            .connected) {
                                                      return RaisedButton(
                                                        child: Text('OPEN'),
                                                        onPressed: () {},
                                                      );
                                                    }
                                                    return SizedBox();
                                                  },
                                                ),
                                              ))
                                          .toList(),
                                    );
                                  } else if (snapshot.data.length == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                              'No Bluetooth Device Found!!!')),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                            'Please Check your Bluetooth Connection!!!'),
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          child: DropdownButtonFormField(
                              isExpanded: true,
                              hint: Text('Choose your gender'),
                              value: _sex,
                              icon: Icon(Icons.person),
                              validator: (value) =>
                                  value != null && value.isNotEmpty
                                      ? null
                                      : 'Please choose your gender',
                              onChanged: (value) {
                                setState(() {
                                  _sex = value;
                                });
                              },
                              items: _sexList
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text('$e')))
                                  .toList()),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          child: DropdownButtonFormField(
                              isExpanded: true,
                              hint: Text('Patient Status'),
                              validator: (value) =>
                                  value != null && value.isNotEmpty
                                      ? null
                                      : 'Please choose your patient status',
                              value: _status,
                              icon: Icon(Icons.local_hospital),
                              onChanged: (value) {
                                setState(() {
                                  _status = value;
                                });
                              },
                              items: _statusList
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text('$e')))
                                  .toList()),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          child: DropdownButtonFormField(
                              isExpanded: true,
                              hint: Text('Choose your location'),
                              value: _location,
                              icon: Icon(Icons.pin_drop),
                              validator: (value) =>
                                  value != null && value.isNotEmpty
                                      ? null
                                      : 'Please choose your location',
                              onChanged: (value) {
                                setState(() {
                                  _location = value;
                                });
                              },
                              items: tanzanianRegions
                                  .map((e) => DropdownMenuItem(
                                      value: e['city'],
                                      child: Text('${e['city']}')))
                                  .toList()),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _ageController,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value.isEmpty ? 'Please enter your age' : null,
                          onChanged: (value) => setState(() {
                            _age = value;
                          }),
                          decoration: InputDecoration(
                              labelText: 'Age',
                              contentPadding: EdgeInsets.all(20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    )),
              ),
            ),
          );
  }
}
