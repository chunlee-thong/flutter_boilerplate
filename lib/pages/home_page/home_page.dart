import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../widgets/buttons/small_icon_button.dart';
import '../../widgets/UI_helper.dart';
import '../../widgets/state_widgets/connection_checker.dart';

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
                onPressed: () async {
                  dynamic value = await UIHelper.showGeneralMessageDialog(context, "Hello world");
                  print("return value: $value");
                },
              ),
              Switch.adaptive(
                onChanged: (value) {},
                value: true,
              ),
              SmallIconButton(
                onTap: () {},
                backgroundColor: Colors.red,
                icon: Icon(Icons.add),
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
