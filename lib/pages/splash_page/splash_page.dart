import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/pages/home_page/home_page.dart';
import 'package:flutter_boiler_plate/utils/navigator.dart';

import '../../constant/colors.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  void onSplashing() async {
    await Future.delayed(const Duration(seconds: 1));
    PageNavigator.pushReplacement(context, MyHomePage());
  }

  @override
  void initState() {
    onSplashing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Text(
          "Loading...",
          style: TextStyle(fontSize: 32, color: Colors.black),
        ),
      ),
    );
  }
}
