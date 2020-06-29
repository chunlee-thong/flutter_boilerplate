import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/model/dummy_model.dart';
import 'package:provider/provider.dart';
import '../../api_service/mock_api_provider.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import '../../bloc/base_extend_stream.dart';
import '../../widgets/widget_helper.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BaseStream<LoginResponse> baseStream = BaseStream();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    baseStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalization.of(context);
    return Provider<BaseStream<LoginResponse>>(
      create: (_) => baseStream,
      child: Scaffold(
        appBar: AppBar(title: Text("Flutter Boilerplate")),
        body: Center(
          child: ConnectionChecker(
            reactToConnectionChange: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamHandler<LoginResponse>(
                  stream: baseStream.stream,
                  initialData: LoginResponse(message: "Not login yet"),
                  error: (error) => Text(error, textAlign: TextAlign.center),
                  ready: (data) {
                    return Text(data.message);
                  },
                ),
                LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var baseStream = Provider.of<BaseStream<LoginResponse>>(context);
    return ActionButton(
      onPressed: () async {
        baseStream.operation(() async {
          return await MockApiProvider().loginUser();
        }, loadingOnRefesh: true);
      },
      child: Text("Login User"),
    );
  }
}
