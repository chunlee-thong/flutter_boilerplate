import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import '../../api_service/index.dart';
import '../../api_service/mock_api_service.dart';
import '../../models/others/login_response.dart';
import '../../pages/root_page/root_page.dart';
import '../../utils/auth_utils.dart';
import '../../utils/service_locator.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/common/ui_helper.dart';
import '../../widgets/form_input/primary_text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with FormPageMixin {
  MockApiService mockApiService = getIt<MockApiService>();
  TextEditingController emailTC;
  TextEditingController passwordTC;

  void onLogin() async {
    if (formKey.currentState.validate()) {
      try {
        LoginResponse loginResponse = await userApiService.loginUser(
          email: emailTC.text.trim(),
          password: passwordTC.text.trim(),
        );
        await AuthUtils.onLoginSuccess(context, loginResponse);
        PageNavigator.pushReplacement(context, RootPage());
      } catch (e) {
        UIHelper.showMessageDialog(context, e.toString());
      }
    }
  }

  @override
  void initState() {
    emailTC = TextEditingController(text: "test1@gmail.com");
    passwordTC = TextEditingController(text: "123456789");
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
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 200, horizontal: 12),
          children: <Widget>[
            PrimaryTextField(
              textInputType: TextInputType.emailAddress,
              controller: emailTC,
              validator: (value) => JinFormValidator.validateEmail(value),
              label: "Email",
            ),
            SpaceY(16),
            PrimaryTextField(
              textInputType: TextInputType.visiblePassword,
              controller: passwordTC,
              validator: (value) =>
                  JinFormValidator.validateField(value, 'password'),
              obsecure: true,
              label: "Password",
            ),
            PrimaryButton(
              onPressed: onLogin,
              child: Text("LOGIN"),
            ),
          ],
        ),
      ),
    );
  }
}
