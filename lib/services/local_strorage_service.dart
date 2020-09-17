import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const FlutterSecureStorage fss = FlutterSecureStorage();
  static SharedPreferences sharedPreferences;
  static const String TOKEN_KEY = "key.token";

  //Prevent initizlization
  LocalStorage._();

  static Future<void> initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<String> getToken() async {
    return await fss.read(key: TOKEN_KEY);
  }

  static Future<void> save({
    @required String key,
    @required String value,
  }) async {
    await fss.write(key: key, value: value);
  }

  static Future<String> read({@required String key}) async {
    return await fss.read(key: key);
  }

  static Future<void> deleteAll() async {
    await fss.deleteAll();
  }
}
