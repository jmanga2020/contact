import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothMechanisim {
    static Future<void> requestDiscoverable({int timeOut = 120}) async {
    await FlutterBluetoothSerial.instance.requestDiscoverable(timeOut);
  }
}