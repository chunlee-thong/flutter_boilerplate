import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_service.dart';

class SharedPreferencesStorageService extends LocalStorage {
  @override
  Future clearImpl() async {
    final spf = await SharedPreferences.getInstance();
    await spf.clear();
  }

  @override
  Future<void> writeStringImpl(
      {required String key, required String value}) async {
    final spf = await SharedPreferences.getInstance();
    await spf.setString(key, value);
  }

  @override
  Future<String?> readStringImpl({required String key}) async {
    final spf = await SharedPreferences.getInstance();
    String? data = spf.getString(key);
    return data;
  }

  @override
  Future<bool?> readBoolImpl({required String key}) async {
    final spf = await SharedPreferences.getInstance();
    return spf.getBool(key);
  }

  @override
  Future<void> writeBoolImpl({required String key, required bool value}) async {
    final spf = await SharedPreferences.getInstance();
    await spf.setBool(key, value);
  }
}
