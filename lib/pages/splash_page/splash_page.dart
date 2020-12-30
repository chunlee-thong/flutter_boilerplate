import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/provider/theme_provider.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import '../../constant/theme.dart';
import '../../services/local_storage_service.dart';
import '../home_page/home_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  void onSplashing() async {
    await LocalStorage.initialize();
    ThemeProvider.getProvider(context).initializeTheme();
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
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Text(
          "Loading...",
          style: TextStyle(fontSize: 32, color: Colors.black),
        ),
      ),
    );
  }
}
