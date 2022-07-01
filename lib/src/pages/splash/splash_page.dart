import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_theme_color.dart';
import '../../pages/root/root_page.dart';
import '../../providers/auth_provider.dart';
import '../../providers/index.dart';
import '../../widgets/state_widgets/error_widget.dart';
import '../../widgets/state_widgets/loading_widget.dart';
import '../sign_in/sign_in_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  FutureManager<bool> splashManager = FutureManager();
  late final AuthProvider authProvider = readProvider<AuthProvider>(context);

  Future<bool> onSplashing() async {
    bool isLoggedIn = await authProvider.initializeUser();
    await Future.delayed(const Duration(seconds: 1));
    SuraPageNavigator.pushAndRemove(
      context,
      isLoggedIn ? const RootPage() : const SignInPage(),
    );
    return true;
  }

  @override
  void initState() {
    splashManager.execute(() => onSplashing());
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
        loading: const LoadingWidget(color: Colors.white),
        error: (error) {
          return CustomErrorWidget(
            error: error,
            hasAppBar: true,
            onRefresh: () => onSplashing(),
          );
        },
        ready: (context, ready) => const LoadingWidget(color: Colors.white),
      ),
    );
  }
}
