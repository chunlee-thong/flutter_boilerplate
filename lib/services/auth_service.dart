import 'package:flutter/cupertino.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import '../constant/app_constant.dart';
import '../models/response/user/auth_response.dart';
import '../pages/login_page/login_page.dart';
import '../providers/user_provider.dart';
import '../services/local_storage_service.dart';

class AuthService {
  static Future<void> onLoginSuccess(BuildContext context, AuthResponse loginResponse) async {
    await LocalStorage.save(key: LocalStorage.TOKEN_KEY, value: loginResponse.token);
    await LocalStorage.save(key: LocalStorage.ID_KEY, value: loginResponse.userId);
    UserProvider.getProvider(context).setLoginStatus(true);
    await UserProvider.getProvider(context).getUserInfo();
  }

  static void logOutUser(BuildContext context, {bool showConfirmation = true}) async {
    void onLogout() async {
      await LocalStorage.deleteAll();
      AppConstant.clean();
      UserProvider.getProvider(context).setLoginStatus(false);
      PageNavigator.pushAndRemove(context, LoginPage());
    }

    if (!showConfirmation) {
      onLogout();
      return;
    }

    JinNavigator.dialog(
      JinConfirmationDialog(
        content: Text("Do you want to logout?"),
        title: "Warning",
        onConfirm: onLogout,
        confirmText: "Logout",
        cancelText: "Cancel",
      ),
    );
  }
}
