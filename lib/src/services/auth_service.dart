import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../constant/app_constant.dart';
import '../models/response/user/auth_response.dart';
import '../pages/login_page/login_page.dart';
import '../providers/user_provider.dart';
import '../services/local_storage_service.dart';

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
    AppConstant.TOKEN = await LocalStorage.get(key: TOKEN_KEY);
    AppConstant.USER_ID = await LocalStorage.get(key: ID_KEY);
  }

  static Future<void> refreshUserToken() async {
    String refreshToken = await LocalStorage.get(key: REFRESH_TOKEN_KEY);
    try {
      //Response response = await BaseHttpClient.dio.post("/", data:{"refresh_token":refresh_token});
      // if (response.data['status'] == 1 || response.data['status'] == true) {
      //   String newToken = response.....
      //   String newRefreshToken = response....
      //   await LocalStorage.save(key: TOKEN_KEY, value: newToken);
      //   await LocalStorage.save(key: REFRESH_TOKEN_KEY, value: newRefreshToken);
      //   AppConstant.TOKEN = newToken;
      // } else {
      //   throw response.data['message'];
      // }
    } catch (exception) {
      throw exception;
    }
  }

  static void logOutUser(BuildContext context, {bool showConfirmation = true}) async {
    void onLogout() async {
      await LocalStorage.clear();
      AppConstant.clean();
      UserProvider.getProvider(context).setLoginStatus(false);
      PageNavigator.pushAndRemove(context, LoginPage());
    }

    if (!showConfirmation) {
      await onLogout();
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
