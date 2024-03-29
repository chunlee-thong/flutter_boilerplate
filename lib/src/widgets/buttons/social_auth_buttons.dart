import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

import '../../core/constant/locale_keys.dart';
import '../../core/style/color.dart';
import '../../core/utilities/exception_handler.dart';
import '../../models/response/user/social_auth_data.dart';
import '../../services/index.dart';

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
            socialAuthData = await socialAuthService.loginWithFacebook();
            // socialAuthData.authResponse = userRepository.loginWithFaceBook();
            break;
          case SocialSignIn.google:
            socialAuthData = await socialAuthService.loginWithGoogle();
            // socialAuthData.authResponse = userRepository.loginWithGoogle();
            break;
          case SocialSignIn.apple:
            socialAuthData = await socialAuthService.loginWithApple();
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
        SkadiAsyncButton(
          onPressed: () {
            onSocialSignIn(
              context: context,
              signInMethod: SocialSignIn.facebook,
            );
          },
          margin: margin,
          startIcon: const Icon(AntIcons.facebookFilled),
          backgroundColor: AppColor.fbColor,
          child: Text(tr(LocaleKeys.sign_in_with, args: ["Facebook"])),
        ),
        SkadiAsyncButton(
          onPressed: () {
            onSocialSignIn(
              context: context,
              signInMethod: SocialSignIn.google,
            );
          },
          margin: margin,
          startIcon: const Icon(AntIcons.googleCircleFilled),
          backgroundColor: AppColor.googleRed,
          child: Text(tr(LocaleKeys.sign_in_with, args: ["Google"])),
        ),
        SkadiAsyncButton(
          onPressed: () {
            onSocialSignIn(
              context: context,
              signInMethod: SocialSignIn.apple,
            );
          },
          margin: margin,
          startIcon: const Icon(AntIcons.appleFilled),
          backgroundColor: AppColor.appleColor,
          child: Text(tr(LocaleKeys.sign_in_with, args: ["Apple"])),
        ),
      ],
    );
  }
}
