import 'package:shared_preferences/shared_preferences.dart';

Future<void> addBool({String key, bool value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<bool> getBool({String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool valueReturn;
  if (!prefs.containsKey(key)) {
    await addBool(key: key, value: false);
  }
  valueReturn = prefs.getBool(key) ?? false;
  return valueReturn;
}

Future<void> addString({String key, String value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String> getString({String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String valueReturn;
  if (!prefs.containsKey(key)) {
    await addString(key: key, value: null);
  }
  valueReturn = prefs.getString(key) ?? null;
  return valueReturn;
}
