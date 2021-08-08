import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/src/constant/locale_keys.dart';

import '../../constant/app_config.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/dialog/language_picker_dialog.dart';
import '../../widgets/ui_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: AppConfig.APP_NAME),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              fullWidth: false,
              margin: const EdgeInsets.all(16),
              onPressed: () {
                showDialog(context: context, builder: (context) => LanguagePickerDialog());
              },
              child: Text(tr(LocaleKeys.change_language)),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          //ThemeProvider.getProvider(context).switchTheme();
          await UIHelper.showMessageDialog(context, "You have click change Theme");
          await UIHelper.showErrorDialog(context, "There is an error");
        },
        child: Text(LocaleKeys.switch_theme.tr()),
      ),
    );
  }
}
