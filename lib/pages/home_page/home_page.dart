import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/constant/app_constant.dart';
import 'package:flutter_boiler_plate/constant/locale_keys.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import './../dummy_page/dummy_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text(
              tr(LocaleKeys.you_have_click, args: ["$count"]),
            ),
            RaisedButton(
              onPressed: () {
                context.locale =
                    context.locale == KH_LOCALE ? EN_LOCALE : KH_LOCALE;
              },
              child: Text("Change Locale"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => count++),
        child: Icon(Icons.add),
      ),
    );
  }
}
