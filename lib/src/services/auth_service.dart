import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../api/client/http_client.dart';
import '../constant/app_constant.dart';
import '../constant/locale_keys.dart';
import '../models/others/user_credential.dart';
import '../models/response/user/auth_response.dart';
import '../pages/sign_in_page/sign_in_page.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../utils/logger.dart';
import 'local_storage_service/local_storage_service.dart';

class AuthService {
  //
  static Future<void> onLoginSuccess(BuildContext context, AuthResponse loginResponse) async {
    await LocalStorage.write(key: TOKEN_KEY, value: loginResponse.token);
    await LocalStorage.write(key: ID_KEY, value: loginResponse.userId);
    await LocalStorage.write(key: REFRESH_TOKEN_KEY, value: loginResponse.refreshToken);
    await LocalStorage.write<bool>(key: LOGIN_KEY, value: true);
    await initializeUserCredential();
    AuthProvider.getProvider(context).setLoginStatus(true);
    await UserProvider.getProvider(context).getUserInfo();
  }

  static Future<void> initializeUserCredential() async {
    String? token = await LocalStorage.read<String>(key: TOKEN_KEY);
    String? refreshToken = await LocalStorage.read<String>(key: REFRESH_TOKEN_KEY);
    String? userId = await LocalStorage.read<String>(key: ID_KEY);

    TokenPayload tokenPayload = SuraJwtDecoder.decode(token!);
    infoLog("Token Expired date", tokenPayload.expiredDate.toLocal());
    infoLog("token", token);
    infoLog("refresh token", refreshToken);
    infoLog("userId", userId);

    UserCredential.instance.initLocalCredential(
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
    await LocalStorage.write(key: REFRESH_TOKEN_KEY, value: authResponse.refreshToken);
    UserCredential.instance.initLocalCredential(
      token: authResponse.token,
      userId: authResponse.userId,
    );
    return authResponse.token;
  }

  static void logOutUser(BuildContext context, {bool showConfirmation = true}) async {
    Future onLogout() async {
      await LocalStorage.clear();
      UserCredential.instance.clearCredential();
      AuthProvider.getProvider(context).setLoginStatus(false);
      SuraPageNavigator.pushAndRemove(context, const SignInPage());
    }

    if (!showConfirmation) {
      await onLogout.call();
      return;
    }

    await showDialog(
      context: context,
      builder: (dialogContext) => SuraConfirmationDialog(
        content: Text(LocaleKeys.are_you_want_logout.tr()),
        title: LocaleKeys.confirmation.tr(),
        onConfirm: onLogout,
        confirmText: LocaleKeys.logout.tr(),
        cancelText: tr(LocaleKeys.cancel),
      ),
    );
  }
}
