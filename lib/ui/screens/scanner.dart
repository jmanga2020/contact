import 'dart:async';

import 'package:contact_tracing/services/utils/blue.dart';
import 'package:contact_tracing/ui/screens/animation/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  @override
  void initState() {
    super.initState();
    BluetoothMechanisim.requestDiscoverable();
    _blueInit();
    _discoveredDevices();
  }

  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

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

  Future<void> _discoveredDevices() async {
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

    _streamSubscription.onDone(() {});
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _enableBluetooth() async {
    await FlutterBluetoothSerial.instance.requestEnable();
  }

  StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> _results =
      List<BluetoothDiscoveryResult>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanned Devices'),
      ),
      body: _bluetoothState.isEnabled
          ? _results.isNotEmpty
              ? Scrollbar(
                  child: ListView.separated(
                      itemBuilder: (_, i) => ListTile(
                            trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_sharp)),
                            subtitle: Text('${_results[i].device.address}'),
                            title: Text(
                                '${i + 1}. ${_results[i].device.name ?? 'Unknown'}'),
                          ),
                      separatorBuilder: (_, i) => Divider(),
                      itemCount: _results.length))
              : UniversalLoader(
                  label: 'Searching for available devices',
                )
          : Center(
              child: ElevatedButton(
                child: Text('Power ON Bluetooth'),
                onPressed: () async {
                  _enableBluetooth();
                },
              ),
            ),
    );
  }
}
