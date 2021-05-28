import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../../page_templates/change_password_page.dart';
import '../../../page_templates/reset_password_page.dart';
import '../../../page_templates/update_user_info_page.dart';
import '../../widgets/common/ui_helper.dart';

class TemplatePages extends StatefulWidget {
  TemplatePages({Key? key}) : super(key: key);
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
            leading: Icon(Icons.pages),
            title: Text("Change password page"),
            onTap: () {
              PageNavigator.push(context, ChangePasswordPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.pages),
            title: Text("Update user info page"),
            onTap: () {
              PageNavigator.push(context, UpdateUserInfoPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.pages),
            title: Text("Reset password page"),
            onTap: () {
              PageNavigator.push(context, ResetPasswordPage());
            },
          ),
        ],
      ),
    );
  }
}
