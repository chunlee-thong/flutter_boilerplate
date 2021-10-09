import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_manager/sura_manager.dart';

import '../../constant/locale_keys.dart';
import '../../models/response/user/user_model.dart';
import '../../providers/user_provider.dart';
import '../../services/auth_service.dart';
import '../../widgets/state_widgets/error_widget.dart';
import '../../widgets/ui_helper.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(
        title: LocaleKeys.profile.tr(),
        actions: [
          IconButton(
            icon: const Icon(FlutterIcons.log_out_ent),
            onPressed: () {
              AuthService.logOutUser(context);
            },
          )
        ],
      ),
      body: FutureManagerBuilder<UserModel>(
        futureManager: UserProvider.getProvider(context).userManager,
        error: (error) => CustomErrorWidget(
          message: error,
          onRefresh: UserProvider.getProvider(context).getUserInfo,
        ),
        ready: (context, user) {
          return Column(
            children: [
              ListTile(title: Text(user.firstName!), subtitle: Text(tr(LocaleKeys.first_name))),
              ListTile(title: Text(user.lastName!), subtitle: Text(LocaleKeys.last_name.tr())),
              ListTile(title: Text(user.email!), subtitle: Text(LocaleKeys.email.tr())),
            ],
          );
        },
      ),
    );
  }
}
