import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/locale_keys.dart';
import '../../http/repository/index.dart';
import '../../models/response/user/auth_response.dart';
import '../../pages/root_page/root_page.dart';
import '../../services/auth_service.dart';
import '../../utils/exception_handler.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/social_auth_buttons.dart';
import '../../widgets/common/ellipsis_text.dart';
import '../../widgets/common/keyboard_dismiss.dart';
import '../../widgets/form_input/primary_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SuraFormMixin {
  late TextEditingController emailTC, passwordTC;

  void onLogin() async {
    if (isFormValidated) {
      await ExceptionHandler.run(context, () async {
        var email = emailTC.text.trim();
        var password = passwordTC.text.trim();
        AuthResponse loginResponse = await userRepository.loginUser(
          email: email,
          password: password,
        );
        await AuthService.onLoginSuccess(context, loginResponse);
        SuraPageNavigator.pushReplacement(context, const RootPage());
      });
    }
  }

  @override
  void initState() {
    emailTC = TextEditingController(text: "");
    passwordTC = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    emailTC.dispose();
    passwordTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismiss(
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              children: <Widget>[
                PrimaryTextField(
                  key: const ValueKey("emailTC"),
                  textInputType: TextInputType.emailAddress,
                  controller: emailTC,
                  label: tr(LocaleKeys.email),
                ),
                const SpaceY(16),
                PrimaryTextField(
                  key: const ValueKey("passwordTC"),
                  textInputType: TextInputType.visiblePassword,
                  controller: passwordTC,
                  obscure: true,
                  label: tr(LocaleKeys.password),
                ),
                PrimaryButton(
                  onPressed: onLogin,
                  child: EllipsisText(tr(LocaleKeys.login)),
                ),
                const SpaceY(100),
                SocialAuthButtons(onLoginCompleted: (data) {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
