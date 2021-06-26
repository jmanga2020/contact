import 'package:shared_preferences/shared_preferences.dart';

class TempMemory {

  /* STORED VALUES
  splash
  */

  ///method to write to local memory [boolean]
  static Future<void> writeBool({String key, bool value}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(key, value);
  }

  ///method to get from local memory [boolean]
  static Future<bool> getBool({String key}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(key);
  }
}
