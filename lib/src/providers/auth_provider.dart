import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/services/social_auth_service.dart';
import 'package:provider/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../constant/locale_keys.dart';
import '../http/repository/index.dart';
import '../models/response/user/auth_response.dart';
import '../models/response/user/social_auth_data.dart';
import '../pages/sign_in/sign_in_page.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service/local_storage_service.dart';
import 'user_provider.dart';

class AuthProvider extends ChangeNotifier {
  final UserProvider userProvider;
  AuthProvider({required this.userProvider});

  bool _authenticated = false;
  bool get authenticated => _authenticated;

  static AuthProvider getProvider(BuildContext context, [bool listen = false]) {
    return Provider.of<AuthProvider>(context, listen: listen);
  }

  Future<bool> initializeUser() async {
    bool isLoggedIn = await getLoginStatus();
    _setLoginStatus(isLoggedIn);
    if (isLoggedIn) {
      await AuthService.initializeUserCredential();
      await userProvider.getUserInfo(throwError: true);
    }
    return isLoggedIn;
  }

  void _setLoginStatus(bool status) {
    _authenticated = status;
    notifyListeners();
  }

  Future<bool> getLoginStatus() async {
    String? token = await LocalStorage.read<String>(key: kTokenKey);
    return token != null;
  }

  Future<void> loginWithPassword(String email, String password) async {
    AuthResponse authResponse = await userRepository.loginUser(
      email: email,
      password: password,
    );
    await AuthService.saveUserCredential(authResponse);
    _setLoginStatus(true);
    await userProvider.getUserInfo(throwError: true);
  }

  Future<void> loginWithSocial(SocialAuthData authData) async {
    AuthResponse authResponse = authData.authResponse;
    await AuthService.saveUserCredential(authResponse);
    _setLoginStatus(true);
    await userProvider.getUserInfo(throwError: true);
  }

  Future<void> logOutUser(BuildContext context, {bool showConfirmation = true}) async {
    //
    Future onLogout() async {
      await LocalStorage.clear();
      SocialAuthService.signOutAll();
      AuthService.clearLocalCredential();
      _setLoginStatus(false);
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
