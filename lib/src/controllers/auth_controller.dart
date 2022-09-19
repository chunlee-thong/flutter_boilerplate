import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/controllers/index.dart';
import 'package:flutter_boilerplate/src/widgets/common/bottom_navigation_widget.dart';
import 'package:skadi/skadi.dart';

import '../core/constant/locale_keys.dart';
import '../models/response/user/auth_response.dart';
import '../models/response/user/social_auth_data.dart';
import '../pages/sign_in/sign_in_page.dart';
import '../repositories/index.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service/local_storage_service.dart';
import '../services/social_auth_service.dart';
import 'user_controller.dart';

class AuthController extends ChangeNotifier {
  final UserController userController;
  AuthController({required this.userController});

  bool _authenticated = false;
  bool get authenticated => _authenticated;

  Future<bool> initializeUser() async {
    bool isLoggedIn = await getLoginStatus();
    _setLoginStatus(isLoggedIn);
    if (isLoggedIn) {
      await AuthService.initializeUserCredential();
      await userController.getUserInfo(throwError: true);
    }
    return isLoggedIn;
  }

  void _setLoginStatus(bool status) {
    _authenticated = status;
    notifyListeners();
  }

  Future<bool> getLoginStatus() async {
    String? token = await LocalStorage.read<String>(key: kTokenKey);
    bool? login = await LocalStorage.read<bool>(key: kLoginKey);
    return token != null && login == true;
  }

  Future<void> loginWithPassword(String email, String password) async {
    AuthResponse authResponse = await userRepository.loginUser(
      email: email,
      password: password,
    );
    await AuthService.saveUserCredential(authResponse);
    _setLoginStatus(true);
    await userController.getUserInfo(throwError: true);
  }

  Future<void> loginWithSocial(SocialAuthData authData) async {
    AuthResponse authResponse = authData.authResponse;
    await AuthService.saveUserCredential(authResponse);
    _setLoginStatus(true);
    await userController.getUserInfo(throwError: true);
  }

  Future<void> logOutUser(BuildContext context, {bool showConfirmation = true}) async {
    //
    Future onLogout() async {
      await LocalStorage.clear();
      SocialAuthService.signOutAll();
      _setLoginStatus(false);
      readProvider<BottomNavigationController>(context).resetIndex();
      SkadiNavigator.pushAndRemove(context, const SignInPage());
    }

    if (!showConfirmation) {
      await onLogout.call();
      return;
    }

    await showDialog(
      context: context,
      builder: (dialogContext) => SkadiConfirmationDialog.danger(
        content: Text(LocaleKeys.are_you_want_logout.tr()),
        title: LocaleKeys.confirmation.tr(),
        onConfirm: onLogout,
        confirmText: LocaleKeys.logout.tr(),
        cancelText: tr(LocaleKeys.cancel),
      ),
    );
  }
}
