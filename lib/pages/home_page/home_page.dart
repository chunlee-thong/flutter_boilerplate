import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/widgets/UI_helper.dart';
import 'package:flutter_boiler_plate/widgets/state_widgets/connection_checker.dart';

import '../../constant/colors.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalization.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Boilerplate")),
      body: Center(
        child: ConnectionChecker(
          reactToConnectionChange: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('horse').tr(context: context, gender: 'female'),
                color: primaryColor,
                onPressed: () async {
                  dynamic value = await UIHelper.showGeneralMessageDialog(context, "Hello world");
                  print("return value: $value");
                },
              ),
              Card(
                child: FlatButton(
                  child: Text("Click me"),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (data.locale == Locale('en', 'US'))
            data.locale = Locale('km', 'KH');
          else
            data.locale = Locale('en', 'US');
        },
        child: Icon(Icons.language),
      ),
    );
  }
}
