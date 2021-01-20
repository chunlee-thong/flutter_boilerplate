import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import '../../constant/color_theme.dart';
import '../../provider/theme_provider.dart';
import '../../services/local_storage_service.dart';
import '../login_page/login_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  void onSplashing() async {
    await LocalStorage.initialize();
    ThemeProvider.getProvider(context).initializeTheme();
    await Future.delayed(const Duration(seconds: 1));
    PageNavigator.pushReplacement(context, LoginPage());
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
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
      ),
    );
  }
}
