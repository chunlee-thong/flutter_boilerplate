import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/widgets/common/get_it_injector.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../widgets/ui_helper.dart';
import 'page_templates/change_password_page.dart';
import 'page_templates/reset_password_page.dart';
import 'page_templates/update_user_info_page.dart';

class UpdateUserController extends GetItInjectable {
  final String username = "chunlee";
}

class PasswordController extends GetItInjectable {
  final String password = "123456";
}

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
              SuraPageNavigator.push(context, const ChangePasswordPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.pages),
            title: const Text("Reset password page"),
            onTap: () {
              SuraPageNavigator.push(context, const ResetPasswordPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.pages),
            title: const Text("Update user info page"),
            onTap: () {
              SuraPageNavigator.push(context, const UpdateUserInfoPage());
            },
          ),
        ],
      ),
    );
  }
}
