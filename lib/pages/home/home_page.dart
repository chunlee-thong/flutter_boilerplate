import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/providers/theme_provider.dart';

import '../../constant/app_config.dart';
import '../../constant/locale_keys.dart';
import '../../widgets/common/ui_helper.dart';
import '../../widgets/dialog/language_picker_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: UIHelper.CustomAppBar(title: AppConfig.APP_NAME),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tr(LocaleKeys.you_have_click, args: ["$count"])),
            RaisedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => LanguagePickerDialog());
              },
              child: Text("Change Locale"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          count++;
          ThemeProvider.getProvider(context).switchTheme();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
