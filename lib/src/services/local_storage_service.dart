import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String TOKEN_KEY = "key.token";
const String REFRESH_TOKEN_KEY = "key.refresh.token";
const String LOGIN_KEY = "key.login";
const String ID_KEY = "key.id";
const String THEME_KEY = "key.theme";

class LocalStorage {
  static const FlutterSecureStorage _fss = FlutterSecureStorage();
  static late SharedPreferences sp;
  //Prevent initialization
  LocalStorage._();

  static Future<void> initialize() async {
    sp = await SharedPreferences.getInstance();
  }

  static Future<bool> saveLoginStatus(bool status) async {
    return await sp.setBool(LOGIN_KEY, status);
  }

  static Future<bool> getLoginStatus() async {
    return await sp.getBool(LOGIN_KEY) ?? false;
  }

  static Future<void> save({
    required String key,
    required String? value,
  }) async {
    await _fss.write(key: key, value: value);
  }

  static Future<String?> get({required String key}) async {
    return await _fss.read(key: key);
  }

  static Future<void> clear() async {
    await sp.clear();
    await _fss.deleteAll();
  }
}
