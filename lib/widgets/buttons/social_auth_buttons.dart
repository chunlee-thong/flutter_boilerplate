import 'package:flutter/material.dart';

import '../../models/response/user/social_auth_data.dart';
import '../../services/social_auth_service.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/common/ui_helper.dart';

class SocialAuthButtons extends StatelessWidget {
  final void Function(SocialAuthData) onLoginCompleted;
  final VoidCallback onPlatformAuthSuccess;
  const SocialAuthButtons({
    Key key,
    @required this.onLoginCompleted,
    this.onPlatformAuthSuccess,
  }) : super(key: key);

  Future<void> onLoginWithFacebook(BuildContext context) async {
    try {
      SocialAuthData data = await SocialAuthService.loginWithFacebook();
      if (data == null) return;
      onPlatformAuthSuccess?.call();
      //Login to server
      //data.authResponse = await userApiService.......;
      //
      onLoginCompleted?.call(data);
    } catch (exception) {
      UIHelper.showErrorDialog(context, exception);
    }
  }

  Future<void> onLoginWithGoogle(BuildContext context) async {
    try {
      SocialAuthData data = await SocialAuthService.loginWithGoogle();
      if (data == null) return;
      onPlatformAuthSuccess?.call();
      //Login to server
      //data.authResponse = await userApiService.......;
      //
      onLoginCompleted?.call(data);
    } catch (exception) {
      UIHelper.showErrorDialog(context, exception);
    }
  }

  Future<void> onLoginWithApple(BuildContext context) async {
    try {
      SocialAuthData data = await SocialAuthService.loginWithApple();
      if (data == null) return;
      onPlatformAuthSuccess?.call();
      //Login to server
      //data.authResponse = await userApiService.......;
      //
      onLoginCompleted?.call(data);
    } catch (exception) {
      UIHelper.showErrorDialog(context, exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          PrimaryButton(
            onPressed: () => onLoginWithFacebook(context),
            child: Text("Sign In with Facebook"),
          ),
          PrimaryButton(
            onPressed: () => onLoginWithGoogle(context),
            child: Text("Sign In with Google"),
          ),
          PrimaryButton(
            onPressed: () => onLoginWithApple(context),
            child: Text("Sign In with Apple"),
          ),
        ],
      ),
    );
  }
}
