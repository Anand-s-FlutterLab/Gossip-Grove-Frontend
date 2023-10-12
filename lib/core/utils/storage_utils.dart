import 'package:shared_preferences/shared_preferences.dart';

Future<void> writeStorage(String name, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(name, value);
}

Future<String?> readStorage(String name) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(name);
}

Future<void> removeStorage(String name) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(name);
}

Future<void> clearStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}