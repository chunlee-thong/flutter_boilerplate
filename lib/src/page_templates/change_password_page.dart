import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../constant/app_dimension.dart';
import '../constant/style_decoration.dart';
import '../widgets/buttons/primary_button.dart';
import '../widgets/form_input/primary_text_field.dart';
import '../widgets/ui_helper.dart';
import '../utils/form_validator.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> with SuraFormMixin {
  late TextEditingController oldPasswordTC;
  late TextEditingController newPasswordTC;
  late TextEditingController confirmNewPasswordTC;

  Future<void> onSubmit() async {
    if (isFormValidated) {
      try {
        String oldPassword = oldPasswordTC.text.trim();
        String newPassword = newPasswordTC.text.trim();

        bool result = await Future.value(true);
      } catch (e) {
        UIHelper.showErrorDialog(context, e);
      }
    }
  }

  @override
  void initState() {
    oldPasswordTC = TextEditingController();
    newPasswordTC = TextEditingController();
    confirmNewPasswordTC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordTC.dispose();
    newPasswordTC.dispose();
    confirmNewPasswordTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: ""),
      body: SingleChildScrollView(
        padding: AppDimension.pageSpacing,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Change your Password", style: kHeaderStyle),
            SpaceY(24),
            buildForm(),
          ],
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          PrimaryTextField(
            controller: oldPasswordTC,
            hint: "Old password",
            obsecure: true,
          ),
          PrimaryTextField(
            controller: newPasswordTC,
            hint: "New password",
            lengthValidator: 6,
            obsecure: true,
          ),
          PrimaryTextField(
            controller: confirmNewPasswordTC,
            hint: "Confirm new password",
            obsecure: true,
            validator: (value) => FormValidator.validateConfirmPassword(value, newPasswordTC.text),
          ),
          PrimaryButton(
            onPressed: onSubmit,
            child: Text("Change Password"),
          ),
        ],
      ),
    );
  }
}
