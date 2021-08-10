import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_tracing/models/patientModel.dart';
import 'package:contact_tracing/notifications/notification.dart';
import 'package:contact_tracing/services/cloud/operations.dart';
import 'package:contact_tracing/services/metrics/deviceMetrics.dart';
import 'package:contact_tracing/services/constants/variables.dart';
import 'package:contact_tracing/services/utils/blue.dart';
import 'package:contact_tracing/ui/screens/animation/loaders.dart';
import 'package:contact_tracing/ui/widgets/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../home.dart';

class PatientDetails extends StatefulWidget {
  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  @override
  void initState() {
    BluetoothMechanisim.requestDiscoverable();
    _blueInit();
    super.initState();
  }

  //bluetooth
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  Map<String, dynamic> _chosenId = Map();
  StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> _results =
      List<BluetoothDiscoveryResult>.empty(growable: true);

  Future<void> _blueInit() async {
    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });
  }

  List<String> _notificationIds = [];

  Future<void> _getNotificationIds() async {
    FirebaseFirestore.instance.collection('Notifications').get().then((value) {
      if (value != null) {
        for (var i in value.docs) {
          Map<String, dynamic> _data = i.data();
          if (_data['region'] == _location &&
              //send for all not me!
              _data['bt'] != deviceAddress) {
            _notificationIds.add(_data['id']);
          }
        }
      }
    });
  }

  String _age, _sex, _location, _status;
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
              await _discoveredDevices();
              setState(() {
                _scanning = false;
              });
            },
    );
  }

  Future<void> _discoveredDevices() async {
    _results?.clear();
    _streamSubscription?.cancel();
    _chosenId?.clear();
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        final existingIndex = _results.indexWhere(
            (element) => element.device.address == r.device.address);
        if (existingIndex >= 0)
          _results[existingIndex] = r;
        else
          _results.add(r);
      });
    });

    _streamSubscription.onDone(() {
      setState(() {
        _scanning = false;
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _notify(i) async {
    await CloudNotifications.sendNotification(
        userIds: [i],
        title: 'Covid Patient',
        sub: 'New user affected in  $_location',
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
                            if (_chosenId.length != 0) {
                              if (_location != null) {
                                await CloudOperations.addToCloud(
                                    serverPath:
                                        'Records/${_chosenId['address']}',
                                    data: PatientModel(
                                            id: _chosenId['address'],
                                            age: _age,
                                            sex: _sex,
                                            location: _location,
                                            status: _status)
                                        .toMap());
                                if (_status == 'Positive') {
                                  await _getNotificationIds();
                                  for (var i in _notificationIds) {
                                    try {
                                      _notify(i);
                                    } catch (e) {
                                      _notify(i);
                                    }
                                  }
                                }
                                setState(() {
                                  _ageController.clear();
                                  _chosenId.clear();
                                  _sex = null;
                                  _status = null;
                                  _location = null;
                                  _loading = false;
                                });
                                showSnack(context,
                                    content: 'Patient Details Submitted');
                              } else {
                                showSnack(context,
                                    error: true,
                                    content: 'Please Choose Patient Residence');
                              }
                            } else {
                              showSnack(context,
                                  error: true,
                                  content:
                                      'Please Pick A Patient Bluetooth ID');
                            }
                          } catch (e) {
                            showSnack(context,
                                error: true,
                                content:
                                    'Submission Failed Please Try Again Later');
                          }
                        }
                      }),
                ),
              ),
            ),
            body: _scanning
                ? UniversalLoader(
                    label: 'Scanning Devices, Please wait...',
                  )
                : Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(30),
                    child: SingleChildScrollView(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _bluetoothState.isEnabled
                                  ? _bluetoothDevices(enabled: true)
                                  : _bluetoothDevices(enabled: false),
                              _results.isNotEmpty
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        width:
                                            DeviceMetrics.deviceWidth(context),
                                        height: DeviceMetrics.deviceHeight(
                                                context) /
                                            5,
                                        child: Scrollbar(
                                          child: ListView.separated(
                                              separatorBuilder: (_, i) =>
                                                  Divider(),
                                              itemCount: _results.length,
                                              itemBuilder: (_, i) => ListTile(
                                                    onTap: () {
                                                      setState(() {
                                                        _chosenId.addAll({
                                                          'name': _results[i]
                                                              .device
                                                              .name,
                                                          'address': _results[i]
                                                              .device
                                                              .address
                                                        });
                                                        _results.clear();
                                                      });
                                                    },
                                                    title: Text(
                                                        '${i + 1}. ${_results[i].device.name ?? 'Unknown'}'),
                                                    subtitle: Text(
                                                        '${_results[i].device.address}'),
                                                  )),
                                        ),
                                      ),
                                    )
                                  : _chosenId.length != 0
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: Text(
                                            'Selected Bluetooth Device: ${_chosenId['name'] ?? 'Unknown'}',
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      : SizedBox(),
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
                                    validator: (value) => value != null &&
                                            value.isNotEmpty
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
                                    hint: Text('Choose patient location'),
                                    value: _location,
                                    icon: Icon(Icons.pin_drop),
                                    validator: (value) =>
                                        value != null && value.isNotEmpty
                                            ? null
                                            : 'Please choose patient location',
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
                                validator: (value) => value.isEmpty
                                    ? 'Please enter your age'
                                    : null,
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
