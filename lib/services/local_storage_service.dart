import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const FlutterSecureStorage _fss = FlutterSecureStorage();
  static SharedPreferences sharedPreferences;
  static const String TOKEN_KEY = "key.token";
  static const String THEME_KEY = "key.theme";

  //Prevent initialization
  LocalStorage._();

  static Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<String> getToken() async {
    return await _fss.read(key: TOKEN_KEY);
  }

  static Future<void> write({
    @required String key,
    @required String value,
  }) async {
    await _fss.write(key: key, value: value);
  }

  static Future<String> read({@required String key}) async {
    return await _fss.read(key: key);
  }

  static Future<void> deleteAll() async {
    await _fss.deleteAll();
  }
}
