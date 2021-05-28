import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../../models/response/user/user_model.dart';
import '../../../providers/user_provider.dart';
import '../../../services/auth_service.dart';
import '../../widgets/common/ui_helper.dart';
import '../../widgets/state_widgets/error_widget.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: "User Profile", actions: [
        IconButton(
          icon: Icon(FlutterIcons.log_out_ent),
          onPressed: () {
            AuthService.logOutUser(context);
          },
        )
      ]),
      body: FutureManagerBuilder<UserModel>(
        futureManager: UserProvider.getProvider(context).userController,
        error: (error) => OnErrorWidget(
          message: error,
          onRefresh: UserProvider.getProvider(context).getUserInfo,
        ),
        ready: (context, user) {
          return Column(
            children: [
              ListTile(title: Text(user.firstName!), subtitle: Text("First name")),
              ListTile(title: Text(user.lastName!), subtitle: Text("Last name")),
              ListTile(title: Text(user.email!), subtitle: Text("Email")),
            ],
          );
        },
      ),
    );
  }
}
