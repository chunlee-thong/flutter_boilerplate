import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:sura_manager/sura_manager.dart';

import '../../constant/app_theme_color.dart';
import '../../pages/root_page/root_page.dart';
import '../../providers/user_provider.dart';
import '../../services/auth_service.dart';
import '../../services/local_storage_service/local_storage_service.dart';
import '../../widgets/state_widgets/error_widget.dart';
import '../../widgets/state_widgets/loading_widget.dart';
import '../login_page/login_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  FutureManager<bool> splashManager = FutureManager();

  Future<bool> onSplashing() async {
    bool? isLoggedIn = await LocalStorage.read<bool>(key: LOGIN_KEY) ?? false;
    if (isLoggedIn) {
      await AuthService.initializeUserCredential();
      UserProvider.getProvider(context).getUserInfo();
    }
    UserProvider.getProvider(context).setLoginStatus(isLoggedIn);
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
        loading: const LoadingWidget(Colors.white),
        error: (error) {
          return OnErrorWidget(
            message: error,
            hasAppBar: true,
            onRefresh: () => onSplashing(),
          );
        },
        ready: (context, ready) => const LoadingWidget(Colors.white),
      ),
    );
  }
}
