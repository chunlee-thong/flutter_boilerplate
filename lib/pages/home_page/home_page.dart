import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/constant/colors.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import '../../widgets/UI_helper.dart' as Local;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

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
                  dynamic value = await Local.UIHelper.showGeneralMessageDialog(
                      context, "Hello world");
                  print("return value: $value");
                },
              ),
              Switch.adaptive(
                onChanged: (value) {},
                value: true,
              ),
              SmallIconButton(
                onTap: () {},
                backgroundColor: primaryColor,
                borderRadius: 32,
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
