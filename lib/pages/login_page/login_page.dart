import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/pages/root_page/root_page.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs<bool>();
  TextEditingController emailTC;
  TextEditingController passwordTC;

  void onLogin() async {
    await Future.delayed(Duration(seconds: 1));
    PageNavigator.pushReplacement(context, RootPage());
  }

  @override
  void initState() {
    emailTC = TextEditingController();
    passwordTC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailTC.dispose();
    isLoading.dispose();
    passwordTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 200, horizontal: 12),
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
            ),
            SpaceY(16),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
            ),
            ActionButton(
              onPressed: onLogin,
              isLoading: isLoading,
              child: Text("LOGIN"),
            ),
          ],
        ),
      ),
    );
  }
}
