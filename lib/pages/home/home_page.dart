import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import './../dummy/dummy_page.dart';
import '../../constant/locale_keys.dart';
import '../../providers/theme_provider.dart';
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
      appBar: AppBar(
        title: Text("Flutter Boilerplate"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_center),
            onPressed: () => PageNavigator.push(context, DummyPage()),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tr(LocaleKeys.you_have_click, args: ["$count"])),
            RaisedButton(
              onPressed: () {
                showDialog(context: context, builder: (context) => LanguagePickerDialog());
              },
              child: Text("Change Locale"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ThemeProvider.getProvider(context).switchTheme();
          UIHelper.showSnackBar(scaffoldKey, "Theme changed");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
