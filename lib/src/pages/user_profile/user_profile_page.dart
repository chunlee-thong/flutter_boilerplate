import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';
import 'package:provider/provider.dart';
import 'package:skadi/skadi.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';
import '../../core/constant/locale_keys.dart';
import '../../models/response/user/user_model.dart';
import '../../widgets/images/user_avatar.dart';
import '../about/about_page.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userController = context.read<UserController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.profile.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              SkadiNavigator.push(context, const AboutPage());
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthController>().logOutUser(context);
            },
          ),
        ],
      ),
      body: FutureManagerBuilder<UserModel>(
        futureManager: userController.userManager,
        ready: (context, user) {
          return Column(
            children: [
              UserAvatar(
                imageUrl: SkadiUtils.picsumImage(),
                onImageChanged: (file) async {},
                radius: 50,
              ),
              ListTile(
                subtitle: EllipsisText(user.firstName),
                title: Text(tr(LocaleKeys.first_name)),
              ),
              ListTile(
                subtitle: EllipsisText(user.lastName),
                title: Text(LocaleKeys.last_name.tr()),
              ),
              ListTile(
                subtitle: EllipsisText(user.email),
                title: Text(LocaleKeys.email.tr()),
              ),
            ],
          );
        },
      ),
    );
  }
}
