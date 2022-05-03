import 'package:dio/dio.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../http/client/http_client.dart';
import '../models/others/user_secret.dart';
import '../models/response/user/auth_response.dart';
import 'local_storage_service/local_storage_service.dart';

class AuthService {
  ///Save user credential to local storage
  static Future saveUserCredential(AuthResponse authResponse) async {
    await LocalStorage.write(key: TOKEN_KEY, value: authResponse.token);
    await LocalStorage.write(key: ID_KEY, value: authResponse.userId);
    await LocalStorage.write(key: REFRESH_TOKEN_KEY, value: authResponse.refreshToken);
    await LocalStorage.write<bool>(key: LOGIN_KEY, value: true);
  }

  ///Init user credential to memory
  static Future<void> initializeUserCredential() async {
    String? token = await LocalStorage.read<String>(key: TOKEN_KEY);
    String? refreshToken = await LocalStorage.read<String>(key: REFRESH_TOKEN_KEY);
    String? userId = await LocalStorage.read<String>(key: ID_KEY);

    TokenPayload tokenPayload = SuraJwtDecoder.decode(token!);
    infoLog("Token Expired date", tokenPayload.expiredDate?.toLocal());
    infoLog("token", token);
    infoLog("refresh token", refreshToken);
    infoLog("userId", userId);

    UserSecret.instance.initLocalCredential(
      token: token,
      userId: userId,
    );
  }

  static clearLocalCredential() {
    UserSecret.instance.clearCredential();
  }

  static Future<String?> refreshUserToken(Dio dio) async {
    String? refreshToken = await LocalStorage.read(key: REFRESH_TOKEN_KEY);
    Response response = await dio.request(
      "/api/user/refresh-token",
      options: Options(
        headers: {"Authorization": "bearer $refreshToken"},
        method: HttpMethod.POST,
      ),
    );
    AuthResponse authResponse = AuthResponse.fromJson(response.data["data"]);
    await LocalStorage.write(key: TOKEN_KEY, value: authResponse.token);
    await LocalStorage.write(key: REFRESH_TOKEN_KEY, value: authResponse.refreshToken);
    await initializeUserCredential();
    return authResponse.token;
  }
}
