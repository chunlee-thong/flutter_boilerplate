import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

import '../../controllers/index.dart';
import '../../controllers/theme_controller.dart';
import '../../core/constant/app_config.dart';
import '../../core/constant/locale_keys.dart';
import '../../core/style/dimension.dart';
import '../../services/analytic_service.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/dialog/language_picker_dialog.dart';
import '../../widgets/ui_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConfig.appName)),
      body: Padding(
        padding: AppDimension.pageSpacing,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              onPressed: () {
                showDialog(context: context, builder: (context) => const LanguagePickerDialog());
              },
              child: Text(tr(LocaleKeys.change_language)),
            ),
            PrimaryButton(
              onPressed: () {
                UIHelper.showErrorDialog(context, "This is an error dialog");
              },
              child: const Text("Show error dialog"),
            ),
            PrimaryButton(
              onPressed: () {
                UIHelper.showMessageDialog(context, "This is a simple dialog");
              },
              child: const Text("Show Simple dialog"),
            ),
            PrimaryButton(
              onPressed: () {
                UIHelper.showSnackBar(context, "This is a SnackBar");
              },
              child: const Text("Show SnackBar"),
            ),
            PrimaryButton(
              onPressed: () {
                UIHelper.showToast(context, "This is a Toast");
              },
              child: const Text("Show Toast"),
            ),
          ],
        ),
      ),
      floatingActionButton: SkadiAsyncButton(
        fullWidth: false,
        height: 40,
        onPressed: () async {
          readProvider<ThemeController>(context).switchTheme();
          logClickEvent(AppAnalyticEvent.change_theme);
        },
        child: Text(LocaleKeys.switch_theme.tr()),
      ),
    );
  }
}
