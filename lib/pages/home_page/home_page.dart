import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/service/api_provider/mock_api_provider.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import '../../widgets/widget_helper.dart';

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
              ActionButton(
                child: Text('horse').tr(context: context, gender: 'female'),
                onPressed: () async {
                  dynamic value = await WidgetHelper.showGeneralMessageDialog(
                      context, "Hello world");
                  print("return value: $value");
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            Map<String, dynamic> data = await MockApiProvider().loginUser();
          } catch (e) {
            WidgetHelper.showGeneralMessageDialog(context, e.toString());
          }
        },
        child: Icon(Icons.language),
      ),
    );
  }
}
