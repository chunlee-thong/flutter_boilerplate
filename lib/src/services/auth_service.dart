import 'package:dio/dio.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../http/http_client.dart';
import '../models/response/user/auth_response.dart';
import 'local_storage_service/local_storage_service.dart';

class AuthService {
  ///Save user credential to local storage
  static Future<void> saveUserCredential(AuthResponse authResponse) async {
    await LocalStorage.write(key: kTokenKey, value: authResponse.token);
    await LocalStorage.write(key: kIdKey, value: authResponse.userId);
    await LocalStorage.write(key: kRefreshTokenKey, value: authResponse.refreshToken);
    await LocalStorage.write<bool>(key: kLoginKey, value: true);
  }

  static Future<void> initializeUserCredential() async {
    String? token = await LocalStorage.read<String>(key: kTokenKey);
    String? refreshToken = await LocalStorage.read<String>(key: kRefreshTokenKey);
    String? userId = await LocalStorage.read<String>(key: kIdKey);

    TokenPayload tokenPayload = SuraJwtDecoder.decode(token!);
    infoLog("Token Expired date", tokenPayload.expiredDate?.toLocal());
    infoLog("token", token);
    infoLog("refresh token", refreshToken);
    infoLog("userId", userId);
  }

  static Future<String?> refreshUserToken(Dio dio) async {
    String? refreshToken = await LocalStorage.read(key: kRefreshTokenKey);
    Response response = await dio.request(
      "/api/user/refresh-token",
      options: Options(
        headers: {"Authorization": "bearer $refreshToken"},
        method: HttpMethod.post,
      ),
    );
    AuthResponse authResponse = AuthResponse.fromJson(response.data["data"]);
    await LocalStorage.write(key: kTokenKey, value: authResponse.token);
    await LocalStorage.write(key: kRefreshTokenKey, value: authResponse.refreshToken);
    return authResponse.token;
  }
}
