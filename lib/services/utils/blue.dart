import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothMechanisim {
  static Future<void> requestDiscoverable({int timeOut = 120}) async {
    await FlutterBluetoothSerial.instance.requestDiscoverable(timeOut);
  }

  static String macMask({String address}) {
    int _length = address.length > 8 ? 8 : address.length - 1;
    String _sub = address.substring(0, _length);
    String _mask = '';
    for (var i = 0; i < (_length + 1); i++) {
      _mask += '*';
    }
    return "$_sub$_mask";
  }
}
