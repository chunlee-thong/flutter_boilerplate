import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/services/social_auth_service.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_theme_color.dart';
import '../../constant/locale_keys.dart';
import '../../models/response/user/social_auth_data.dart';
import '../../utils/exception_handler.dart';

// typedef SocialSignIn = Future<SocialAuthData> Function();

enum SocialSignIn { facebook, google, apple }

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
        late SocialAuthData socialAuthData;
        LoadingOverlayProvider.toggle(true);
        switch (signInMethod) {
          case SocialSignIn.facebook:
            socialAuthData = await SocialAuthService.loginWithFacebook();
            // socialAuthData.authResponse = userRepository.loginWithFaceBook();
            break;
          case SocialSignIn.google:
            socialAuthData = await SocialAuthService.loginWithGoogle();
            // socialAuthData.authResponse = userRepository.loginWithGoogle();
            break;
          case SocialSignIn.apple:
            socialAuthData = await SocialAuthService.loginWithApple();
            // socialAuthData.authResponse = userRepository.loginWithApple();
            break;
        }
        onLoginCompleted.call(socialAuthData);
      },
    );
    LoadingOverlayProvider.toggle(false);
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
              signInMethod: SocialSignIn.facebook,
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
              signInMethod: SocialSignIn.google,
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
              signInMethod: SocialSignIn.apple,
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
