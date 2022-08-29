import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

import '../../../core/constant/locale_keys.dart';
import '../../../core/style/dimension.dart';
import '../../../core/style/textstyle.dart';
import '../../../core/utilities/form_validator.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/form_input/primary_text_field.dart';
import '../../../widgets/ui_helper.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> with SkadiFormMixin {
  late TextEditingController oldPasswordTC;
  late TextEditingController newPasswordTC;
  late TextEditingController confirmNewPasswordTC;

  Future<void> onSubmit() async {
    if (isFormValidated) {
      try {
        await SkadiUtils.wait();
        String oldPassword = oldPasswordTC.text.trim();
        String newPassword = newPasswordTC.text.trim();
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
            Text(tr(LocaleKeys.change_password), style: kHeaderStyle),
            const SpaceY(24),
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
            hint: LocaleKeys.old_password.tr(),
            obscure: true,
          ),
          PrimaryTextField(
            controller: newPasswordTC,
            hint: LocaleKeys.new_password.tr(),
            lengthValidator: 6,
            obscure: true,
          ),
          PrimaryTextField(
            controller: confirmNewPasswordTC,
            hint: LocaleKeys.confirm_new_password.tr(),
            obscure: true,
            validator: (value) => FormValidator.validateConfirmPassword(value, newPasswordTC.text),
          ),
          PrimaryButton(
            onPressed: onSubmit,
            child: Text(LocaleKeys.save.tr()),
          ),
        ],
      ),
    );
  }
}
