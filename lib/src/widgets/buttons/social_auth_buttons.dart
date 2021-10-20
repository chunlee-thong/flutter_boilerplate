import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_theme_color.dart';
import '../../constant/locale_keys.dart';
import '../../models/response/user/social_auth_data.dart';
import '../../services/social_auth_service.dart';
import '../../utils/exception_handler.dart';

class SocialAuthButtons extends StatelessWidget {
  final void Function(SocialAuthData) onLoginCompleted;
  final void Function(bool)? onAuthStateChange;
  const SocialAuthButtons({
    Key? key,
    required this.onLoginCompleted,
    this.onAuthStateChange,
  }) : super(key: key);

  Future<void> onLoginWithFacebook(BuildContext context) async {
    await ExceptionHandler.run(
      context,
      () async {
        SocialAuthData data = await SocialAuthService.loginWithFacebook();
        onAuthStateChange?.call(true);
        //Login to server
        //data.authResponse = await userApiService.......;
        //
        onLoginCompleted.call(data);
      },
      onDone: () {
        onAuthStateChange?.call(false);
      },
    );
  }

  Future<void> onLoginWithGoogle(BuildContext context) async {
    await ExceptionHandler.run(
      context,
      () async {
        SocialAuthData data = await SocialAuthService.loginWithGoogle();

        onAuthStateChange?.call(true);
        //Login to server
        //data.authResponse = await userApiService.......;
        //
        onLoginCompleted.call(data);
      },
      onDone: () {
        onAuthStateChange?.call(false);
      },
    );
  }

  Future<void> onLoginWithApple(BuildContext context) async {
    await ExceptionHandler.run(
      context,
      () async {
        SocialAuthData data = await SocialAuthService.loginWithApple();

        onAuthStateChange?.call(true);
        //Login to server
        //data.authResponse = await userApiService.......;
        //
        onLoginCompleted.call(data);
      },
      onDone: () {
        onAuthStateChange?.call(false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const margin = EdgeInsets.only(bottom: 16);
    const double buttonHeight = 46;
    //final buttonHeight = 40.0;
    return Column(
      children: [
        SuraAsyncButton(
          onPressed: () => onLoginWithFacebook(context),
          child: Text(tr(LocaleKeys.sign_in_with, args: ["Facebook"])),
          margin: margin,
          startIcon: const Icon(FlutterIcons.facebook_ent),
          color: AppColor.fbColor,
          height: buttonHeight,
        ),
        SuraAsyncButton(
          onPressed: () => onLoginWithGoogle(context),
          child: Text(tr(LocaleKeys.sign_in_with, args: ["Google"])),
          margin: margin,
          startIcon: const Icon(FlutterIcons.google_ant),
          color: AppColor.googleRed,
          height: buttonHeight,
        ),
        SuraAsyncButton(
          onPressed: () => onLoginWithApple(context),
          child: Text(tr(LocaleKeys.sign_in_with, args: ["Apple"])),
          margin: margin,
          startIcon: const Icon(FlutterIcons.apple1_ant),
          color: AppColor.appleColor,
          height: buttonHeight,
        ),
      ],
    );
  }
}
