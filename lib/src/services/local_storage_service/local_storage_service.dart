const String TOKEN_KEY = "key.token";
const String REFRESH_TOKEN_KEY = "key.refresh.token";
const String LOGIN_KEY = "key.login";
const String ID_KEY = "key.id";
const String THEME_KEY = "key.theme";

abstract class LocalStorage {
  //Prevent initialization
  static late LocalStorage _localStorage;

  static Future<void> initialize(LocalStorage localStorage) async {
    _localStorage = localStorage;
  }

  //
  Future<void> writeStringImpl({required String key, required String value});
  Future<String?> readStringImpl({required String key});
  //
  Future<void> writeBoolImpl({required String key, required bool value});
  Future<bool?> readBoolImpl({required String key});
  //
  Future clearImpl();

  ///Write value into local storage with provided Type
  ///Use String if Type isn't provided
  static Future<void> write<T>({
    required String key,
    required T value,
  }) async {
    if (T is bool) {
      await _localStorage.writeBoolImpl(key: key, value: value as bool);
    } else {
      await _localStorage.writeStringImpl(key: key, value: value.toString());
    }
  }

  static Future<T?> read<T>({required String key}) async {
    if (T is bool) {
      await _localStorage.readBoolImpl(key: key) as bool;
    } else {
      await _localStorage.readStringImpl(key: key);
    }
  }

  static Future<void> clear() async {
    _localStorage.clearImpl();
  }
}
