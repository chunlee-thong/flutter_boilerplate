import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'local_storage_service.dart';

class FssStorageService extends LocalStorage {
  final _fss = const FlutterSecureStorage();

  @override
  Future clearImpl() async {
    await _fss.deleteAll();
  }

  @override
  Future<void> writeStringImpl({required String key, required dynamic value}) async {
    await _fss.write(key: key, value: value.toString());
  }

  @override
  Future<String?> readStringImpl({required String key}) async {
    return await _fss.read(key: key);
  }

  @override
  Future<bool?> readBoolImpl({required String key}) async {
    String? value = await _fss.read(key: key);
    return value == "1" ? true : false;
  }

  @override
  Future<void> writeBoolImpl({required String key, required bool value}) async {
    String savedValue = value ? "1" : "0";
    await _fss.write(key: key, value: savedValue);
  }
}
