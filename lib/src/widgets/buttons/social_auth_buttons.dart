import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_theme_color.dart';
import '../../constant/locale_keys.dart';
import '../../models/response/user/social_auth_data.dart';
import '../../providers/loading_overlay_provider.dart';
import '../../services/social_auth_service.dart';
import '../../utils/exception_handler.dart';

typedef SocialSignIn = Future<SocialAuthData> Function();

class SocialAuthButtons extends StatelessWidget {
  final void Function(SocialAuthData) onLoginCompleted;
  const SocialAuthButtons({Key? key, required this.onLoginCompleted}) : super(key: key);

  Future<void> onSocialSignIn({
    required BuildContext context,
    required SocialSignIn signInMethod,
  }) async {
    await ExceptionHandler.run(
      context,
      () async {
        SocialAuthData data = await SocialAuthService.loginWithFacebook();
        LoadingOverlayProvider.toggle(true);
        //Login to server
        //data.authResponse = await userApiService.......;
        //
        LoadingOverlayProvider.toggle(false);
        onLoginCompleted.call(data);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const margin = EdgeInsets.only(bottom: 16);

    //final buttonHeight = 40.0;
    return Column(
      children: [
        SuraAsyncButton(
          onPressed: () {
            onSocialSignIn(
              context: context,
              signInMethod: SocialAuthService.loginWithFacebook,
            );
          },
          child: Text(tr(LocaleKeys.sign_in_with, args: ["Facebook"])),
          margin: margin,
          startIcon: const Icon(AntIcons.facebookFilled),
          color: AppColor.fbColor,
        ),
        SuraAsyncButton(
          onPressed: () {
            onSocialSignIn(
              context: context,
              signInMethod: SocialAuthService.loginWithGoogle,
            );
          },
          child: Text(tr(LocaleKeys.sign_in_with, args: ["Google"])),
          margin: margin,
          startIcon: const Icon(AntIcons.googleCircleFilled),
          color: AppColor.googleRed,
        ),
        SuraAsyncButton(
          onPressed: () {
            onSocialSignIn(
              context: context,
              signInMethod: SocialAuthService.loginWithApple,
            );
          },
          child: Text(tr(LocaleKeys.sign_in_with, args: ["Apple"])),
          margin: margin,
          startIcon: const Icon(AntIcons.appleFilled),
          color: AppColor.appleColor,
        ),
      ],
    );
  }
}
