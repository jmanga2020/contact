import 'package:shared_preferences/shared_preferences.dart';

class TempMemory {
  /* STORED VALUES
  splash
  regions
  region
  admin
  */

  ///method to write to local memory [boolean]
  static Future<void> writeBool({String key, bool value}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(key, value);
  }

  ///method to write to local memory [String]
  static Future<void> writeString({String key, String value}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(key, value);
  }

  ///method to get from local memory [boolean]
  static Future<bool> getBool({String key}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(key) ?? true;
  }

  ///method to get from local memory [String]
  static Future<String> getString({String key}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key) ?? '';
  }

  static Future<void> remove({String key}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(key);
  }
}
