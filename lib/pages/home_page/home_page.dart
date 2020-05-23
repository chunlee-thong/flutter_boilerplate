import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/bloc/base_extend_stream.dart';
import 'package:flutter_boiler_plate/service/api_provider/mock_api_provider.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import '../../widgets/widget_helper.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BaseStream<dynamic> baseStream = BaseStream();

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
              StreamHandler(
                stream: baseStream.stream,
                ready: (data) {
                  return Text(data.toString());
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          baseStream.operation(() async {
            dynamic data = await MockApiProvider().loginUser();
            baseStream.addData(data);
          });
        },
        child: Icon(Icons.language),
      ),
    );
  }
}
