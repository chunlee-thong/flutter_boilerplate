import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/core/utilities/localization_asset_loader.dart';
import 'package:future_manager/future_manager.dart';
import 'package:provider/provider.dart';
import 'package:skadi/skadi.dart';

import '../../controllers/auth_controller.dart';
import '../../core/style/color.dart';
import '../../pages/root/root_page.dart';
import '../../widgets/state_widgets/error_widget.dart';
import '../../widgets/state_widgets/loading_widget.dart';
import '../sign_in/sign_in_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  FutureManager<bool> splashManager = FutureManager();
  late final AuthController authController = context.read<AuthController>();
  late var easyLocalizationController = EasyLocalization.of(context)!.delegate.localizationController!;

  Future<bool> onSplashing() async {
    await easyLocalizationController.updateAssetLoader(context, const HttpAssetLoader());
    bool isLoggedIn = await authController.initializeUser();
    await Future.delayed(const Duration(seconds: 1));
    SkadiNavigator.pushAndRemove(
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
