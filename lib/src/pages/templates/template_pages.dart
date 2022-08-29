import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

import '../../widgets/ui_helper.dart';
import 'page_templates/change_password_page.dart';
import 'page_templates/reset_password_page.dart';
import 'page_templates/update_user_info_page.dart';

class TemplatePages extends StatefulWidget {
  const TemplatePages({Key? key}) : super(key: key);
  @override
  _TemplatePagesState createState() => _TemplatePagesState();
}

class _TemplatePagesState extends State<TemplatePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: "Templates"),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.pages),
            title: const Text("Change password page"),
            onTap: () {
              SkadiNavigator.push(context, const ChangePasswordPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.pages),
            title: const Text("Reset password page"),
            onTap: () {
              SkadiNavigator.push(context, const ResetPasswordPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.pages),
            title: const Text("Update user info page"),
            onTap: () {
              SkadiNavigator.push(context, const UpdateUserInfoPage());
            },
          ),
        ],
      ),
    );
  }
}
