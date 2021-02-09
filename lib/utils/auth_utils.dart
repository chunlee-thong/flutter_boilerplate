import 'package:flutter/cupertino.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import '../models/others/login_response.dart';
import '../pages/login_page/login_page.dart';
import '../providers/user_provider.dart';
import '../services/local_storage_service.dart';

class AuthUtils {
  static Future<void> onLoginSuccess(BuildContext context, LoginResponse loginResponse) async {
    UserProvider.getProvider(context).setLoginStatus(true);
    await LocalStorage.save(key: LocalStorage.TOKEN_KEY, value: loginResponse.token);
    await LocalStorage.save(key: LocalStorage.ID_KEY, value: loginResponse.id);
  }

  static void logOutUser(BuildContext context) async {
    await LocalStorage.deleteAll();
    UserProvider.getProvider(context).setLoginStatus(false);
    PageNavigator.pushAndRemove(context, LoginPage());
  }
}
