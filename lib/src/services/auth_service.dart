import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../api/client/http_client.dart';
import '../constant/app_constant.dart';
import '../models/others/user_credential.dart';
import '../models/response/user/auth_response.dart';
import '../pages/login_page/login_page.dart';
import '../providers/user_provider.dart';
import 'local_storage_service/local_storage_service.dart';

class AuthService {
  //
  static Future<void> onLoginSuccess(BuildContext context, AuthResponse loginResponse) async {
    await LocalStorage.write(key: TOKEN_KEY, value: loginResponse.token);
    await LocalStorage.write(key: ID_KEY, value: loginResponse.userId);
    await LocalStorage.write<bool>(key: LOGIN_KEY, value: true);
    await initializeUserCredential();
    UserProvider.getProvider(context).setLoginStatus(true);
    await UserProvider.getProvider(context).getUserInfo();
  }

  static Future<void> initializeUserCredential() async {
    String? token = await LocalStorage.read(key: TOKEN_KEY);
    String? userId = await LocalStorage.read(key: ID_KEY);

    MemoryUserCredential.instance.initMemoryCredential(
      token: token,
      userId: userId,
    );
  }

  static Future<String?> refreshUserToken() async {
    String? refreshToken = await LocalStorage.read(key: REFRESH_TOKEN_KEY);
    Response response = await DefaultHttpClient.dio.request(
      "/api/user/refresh-token",
      options: Options(
        headers: {"Authorization": "bearer $refreshToken"},
        method: HttpMethod.POST,
      ),
    );
    AuthResponse authResponse = AuthResponse.fromJson(response.data["data"]);
    await LocalStorage.write(key: TOKEN_KEY, value: authResponse.token);
    MemoryUserCredential.instance.initMemoryCredential(
      token: authResponse.token,
      userId: authResponse.userId,
    );
    return authResponse.token;
  }

  static void logOutUser(BuildContext context, {bool showConfirmation = true}) async {
    Future onLogout() async {
      await LocalStorage.clear();
      MemoryUserCredential.instance.clearMemoryCredential();
      UserProvider.getProvider(context).setLoginStatus(false);
      PageNavigator.pushAndRemove(context, LoginPage());
    }

    if (!showConfirmation) {
      await onLogout.call();
      return;
    }

    await showDialog(
      context: context,
      builder: (dialogContext) => SuraConfirmationDialog(
        content: Text("Do you want to logout?"),
        title: "Warning",
        onConfirm: onLogout,
        confirmText: "Logout",
        cancelText: "Cancel",
      ),
    );
  }
}
