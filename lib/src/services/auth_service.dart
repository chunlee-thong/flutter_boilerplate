import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/src/models/others/local_user_credential.dart';
import 'package:flutter_boiler_plate/src/utils/service_locator.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../api/client/http_client.dart';
import '../models/response/user/auth_response.dart';
import '../providers/user_provider.dart';
import '../services/local_storage_service.dart';
import '../ui/pages/login_page/login_page.dart';
import '../utils/custom_exception.dart';

class AuthService {
  //
  static Future<void> onLoginSuccess(BuildContext context, AuthResponse loginResponse) async {
    await LocalStorage.save(key: TOKEN_KEY, value: loginResponse.token);
    await LocalStorage.save(key: ID_KEY, value: loginResponse.userId);
    await initializeUserCredential();
    await LocalStorage.saveLoginStatus(true);
    UserProvider.getProvider(context).setLoginStatus(true);
    await UserProvider.getProvider(context).getUserInfo();
  }

  static Future<void> initializeUserCredential() async {
    String? token = await LocalStorage.get(key: TOKEN_KEY);
    String? userId = await LocalStorage.get(key: ID_KEY);

    getIt<LocalUserCredential>().initLocalCrendential(
      token: token,
      userId: userId,
    );
  }

  static Future<String> refreshUserToken() async {
    String? refreshToken = await LocalStorage.get(key: REFRESH_TOKEN_KEY);
    try {
      Response response = await BaseHttpClient.dio.post("/", data: {"refresh_token": refreshToken});
      //String newToken = response.....
      //await LocalStorage.save(key: TOKEN_KEY, value: newToken);
      //AppConstant.TOKEN = newToken;
      return "newToken";
    } on DioError catch (exception) {
      if (exception.type == DioErrorType.response) {
        int? code = exception.response!.statusCode;
        if (code == 401) {
          throw SessionExpiredException();
        } else
          throw exception;
      } else {
        throw exception;
      }
    } catch (exception) {
      throw exception;
    }
  }

  static void logOutUser(BuildContext context, {bool showConfirmation = true}) async {
    Future onLogout() async {
      await LocalStorage.clear();
      getIt<LocalUserCredential>().clearLocalCredential();
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
