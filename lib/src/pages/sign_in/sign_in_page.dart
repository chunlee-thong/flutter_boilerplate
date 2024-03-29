import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:skadi/skadi.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../core/constant/locale_keys.dart';
import '../../core/style/color.dart';
import '../../core/style/dimension.dart';
import '../../core/utilities/exception_handler.dart';
import '../../pages/root/root_page.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/social_auth_buttons.dart';
import '../../widgets/form_input/primary_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SkadiFormMixin {
  late TextEditingController emailTC, passwordTC;

  void onLogin() async {
    if (isFormValidated) {
      await ExceptionHandler.run(
        context,
        () async {
          var email = emailTC.text.trim();
          var password = passwordTC.text.trim();
          await context.read<AuthController>().loginWithPassword(email, password);
          SkadiNavigator.pushReplacement(context, const RootPage());
        },
        errorType: ErrorWidgetType.dialog,
      );
    }
  }

  @override
  void initState() {
    emailTC = TextEditingController(text: "admin@gmail.com");
    passwordTC = TextEditingController(text: "123456");
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
        body: Center(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: AppDimension.pageSpacing,
              child: Column(
                children: <Widget>[
                  SkadiIconButton(
                    onTap: context.read<ThemeController>().switchTheme,
                    icon: const Icon(
                      Icons.class_,
                      color: AppColor.primary,
                      size: 64,
                    ),
                  ),
                  const SpaceY(24),
                  PrimaryTextField(
                    key: const ValueKey("emailTC"),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailTC,
                    label: tr(LocaleKeys.email),
                    prefixIcon: const Icon(LineIcons.envelopeAlt),
                  ),
                  PasswordTextFieldBuilder(
                    builder: (obscure) => PrimaryTextField.password(
                      obscureNotifier: passwordObscureNotifier,
                      key: const ValueKey("passwordTC"),
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordTC,
                      obscure: obscure,
                      label: tr(LocaleKeys.password),
                      prefixIcon: const Icon(LineIcons.lock),
                    ),
                  ),
                  PrimaryButton(
                    startIcon: const Icon(Ionicons.log_in_outline),
                    onPressed: onLogin,
                    child: EllipsisText(tr(LocaleKeys.login)),
                  ),
                  const SpaceY(64),
                  SocialAuthButtons(onLoginCompleted: (data) async {
                    await ExceptionHandler.run(context, () async {
                      await context.read<AuthController>().loginWithSocial(data);
                      SkadiNavigator.pushReplacement(context, const RootPage());
                    });
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
