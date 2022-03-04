import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/constant/app_dimension.dart';
import 'package:sura_flutter/sura_flutter.dart';

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
      floatingActionButton: SuraAsyncButton(
        fullWidth: false,
        height: 40,
        onPressed: () async {
          readThemeProvider(context).switchTheme();
        },
        child: Text(LocaleKeys.switch_theme.tr()),
      ),
    );
  }
}
