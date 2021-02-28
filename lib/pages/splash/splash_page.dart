import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_theme_color.dart';
import '../../pages/root_page/root_page.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/local_storage_service.dart';
import '../login_page/login_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  void onSplashing() async {
    await LocalStorage.initialize();
    bool isLoggedIn = (await LocalStorage.getToken()) != null;
    UserProvider.getProvider(context).setLoginStatus(isLoggedIn);
    ThemeProvider.getProvider(context).initializeTheme();
    await Future.delayed(const Duration(seconds: 1));
    PageNavigator.pushReplacement(context, isLoggedIn ? RootPage() : LoginPage());
  }

  @override
  void initState() {
    onSplashing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.materialPrimary,
      body: Center(
        child: Text(
          "Loading...",
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
      ),
    );
  }
}
