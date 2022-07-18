import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';
import 'package:provider/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/index.dart';
import '../../controllers/user_controller.dart';
import '../../core/constant/locale_keys.dart';
import '../../models/response/user/user_model.dart';
import '../../widgets/images/user_avatar.dart';
import '../../widgets/ui_helper.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userController = context.read<UserController>();
    return Scaffold(
      appBar: UIHelper.CustomAppBar(
        title: LocaleKeys.profile.tr(),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              readProvider<AuthController>(context).logOutUser(context);
            },
          )
        ],
      ),
      body: FutureManagerBuilder<UserModel>(
        futureManager: userController.userManager,
        ready: (context, user) {
          return Column(
            children: [
              UserAvatar(
                imageUrl: SuraUtils.picsumImage(),
                onImageChanged: (file) async {},
                radius: 50,
              ),
              ListTile(
                title: EllipsisText(user.firstName),
                subtitle: Text(tr(LocaleKeys.first_name)),
              ),
              ListTile(
                title: EllipsisText(user.lastName),
                subtitle: Text(LocaleKeys.last_name.tr()),
              ),
              ListTile(
                title: EllipsisText(user.email),
                subtitle: Text(LocaleKeys.email.tr()),
              ),
            ],
          );
        },
      ),
    );
  }
}
