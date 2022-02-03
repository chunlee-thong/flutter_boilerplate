import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constant/app_config.dart';
import '../../constant/locale_keys.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/dialog/language_picker_dialog.dart';
import '../../widgets/ui_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: AppConfig.appName),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          ThemeProvider.getProvider(context).switchTheme();
        },
        child: Text(LocaleKeys.switch_theme.tr()),
      ),
    );
  }
}
