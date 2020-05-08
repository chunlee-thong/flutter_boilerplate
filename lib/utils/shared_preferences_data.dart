import 'package:shared_preferences/shared_preferences.dart';

const LOGIN_KEY = "isLoggedIn";

Future<bool> saveLoggedInStatus(bool status) async {
  final pref = await SharedPreferences.getInstance();
  return pref.setBool(LOGIN_KEY, status);
}

Future<bool> getLoggedInStatus() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getBool(LOGIN_KEY) ?? false;
}
