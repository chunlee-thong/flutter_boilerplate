import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_theme_color.dart';
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
    await ExceptionWatcher(
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
    await ExceptionWatcher(
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
    await ExceptionWatcher(
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
    const margin = const EdgeInsets.only(bottom: 16);
    return Container(
      child: Column(
        children: [
          SuraAsyncButton(
            onPressed: () => onLoginWithFacebook(context),
            child: Text("Sign In with Facebook"),
            margin: margin,
            startIcon: Icon(FlutterIcons.facebook_ent),
            color: AppColor.fbColor,
          ),
          SuraAsyncButton(
            onPressed: () => onLoginWithGoogle(context),
            child: Text("Sign In with Google"),
            margin: margin,
            startIcon: Icon(FlutterIcons.google_ant),
            color: AppColor.googleRed,
          ),
          SuraAsyncButton(
            onPressed: () => onLoginWithApple(context),
            child: Text("Sign In with Apple"),
            margin: margin,
            startIcon: Icon(FlutterIcons.apple1_ant),
            color: AppColor.appleColor,
          ),
        ],
      ),
    );
  }
}
