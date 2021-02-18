import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const FlutterSecureStorage _fss = FlutterSecureStorage();
  static SharedPreferences sp;
  static const String TOKEN_KEY = "key.token";
  static const String ID_KEY = "key.id";
  static const String THEME_KEY = "key.theme";

  //Prevent initialization
  LocalStorage._();

  static Future<void> initialize() async {
    sp = await SharedPreferences.getInstance();
  }

  static Future<String> getToken() async {
    return await _fss.read(key: TOKEN_KEY);
  }

  static Future<void> save({
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
