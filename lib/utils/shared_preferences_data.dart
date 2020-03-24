import 'package:shared_preferences/shared_preferences.dart';

Future<bool> saveLoggedInStatus(bool status) async {
  final pref = await SharedPreferences.getInstance();
  return pref.setBool("isLoggedIn", status);
}

Future<bool> getLoggedInStatus() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getBool("isLoggedIn") ?? false;
}
