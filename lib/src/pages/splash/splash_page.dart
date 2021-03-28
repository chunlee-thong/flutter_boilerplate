import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_theme_color.dart';
import '../../pages/root_page/root_page.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/auth_service.dart';
import '../../services/local_storage_service.dart';
import '../login_page/login_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  FutureManager<bool> splashManager = FutureManager();

  Future<bool> onSplashing() async {
    await LocalStorage.initialize();
    bool isLoggedIn = await LocalStorage.getLoginStatus();
    if (isLoggedIn) {
      AuthService.initializeUserCredential();
      UserProvider.getProvider(context).getUserInfo();
    }
    UserProvider.getProvider(context).setLoginStatus(isLoggedIn);
    ThemeProvider.getProvider(context).initializeTheme();
    await Future.delayed(const Duration(seconds: 1));
    PageNavigator.pushReplacement(context, isLoggedIn ? RootPage() : LoginPage());
    return true;
  }

  @override
  void initState() {
    splashManager.asyncOperation(() => onSplashing());
    super.initState();
  }

  @override
  void dispose() {
    splashManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.materialPrimary,
      body: FutureManagerBuilder<bool>(
        futureManager: splashManager,
        ready: (context, ready) => Center(
          child: Text(
            "Loading...",
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
