import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/widgets/state_widgets/no_data_widget.dart';
import 'package:future_manager/future_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:skadi/skadi.dart';

import 'src/controllers/auth_controller.dart';
import 'src/controllers/theme_controller.dart';
import 'src/controllers/user_controller.dart';
import 'src/core/constant/app_config.dart';
import 'src/core/constant/app_locale.dart';
import 'src/core/style/theme.dart';
import 'src/core/utilities/exception_handler.dart';
import 'src/pages/splash/splash_page.dart';
import 'src/services/analytic_service.dart';
import 'src/widgets/common/bottom_navigation_widget.dart';
import 'src/widgets/state_widgets/error_widget.dart';
import 'src/widgets/state_widgets/loading_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Locale> languages = kAppLanguages.map((lang) => lang.locale).toList();
    const bool useDevicePreview = false;
    return DevicePreview(
      enabled: useDevicePreview,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeController()),
          ChangeNotifierProvider(create: (_) => BottomNavigationController()),
          Provider(create: (context) => UserController()),
          ChangeNotifierProvider(create: (context) => AuthController(userController: context.read<UserController>())),
        ],
        child: OKToast(
          child: EasyLocalization(
            path: AppConfig.languageAssetPath,
            supportedLocales: languages,
            fallbackLocale: enLocale,
            startLocale: enLocale,
            child: Builder(
              builder: (context) => Consumer<ThemeController>(
                builder: (context, themeProvider, child) {
                  return FutureManagerProvider(
                    onFutureManagerError: ExceptionHandler.handleManagerError,
                    errorBuilder: (error, onRefresh) {
                      return CustomErrorWidget(
                        error: error.exception,
                        onRefresh: onRefresh,
                      );
                    },
                    child: SkadiProvider(
                      loadingWidget: const LoadingWidget(),
                      noDataWidget: ((p0) => NoDataWidget(onRefresh: p0)),
                      errorWidget: (error, context) {
                        return CustomErrorWidget(error: error);
                      },
                      child: MaterialApp(
                        navigatorObservers: [
                          SkadiRouteObserver(
                            log: true,
                            analyticCallBack: logScreen,
                          ),
                        ],
                        useInheritedMediaQuery: useDevicePreview,
                        title: AppConfig.appName,
                        theme: AppTheme.primaryTheme(ThemeController.isDark),
                        debugShowCheckedModeBanner: false,
                        localizationsDelegates: context.localizationDelegates,
                        supportedLocales: context.supportedLocales,
                        home: const SplashScreenPage(),
                        locale: context.locale,
                        builder: (context, child) {
                          // ErrorWidget.builder = (detail) {
                          //   return kReleaseMode ? const FlutterCustomErrorRendering() : ErrorWidget(detail.exception);
                          // };
                          return _AppWrapper(child: child!);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppWrapper extends StatelessWidget {
  final Widget child;
  const _AppWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkadiResponsiveBuilder(
      builder: (context) {
        return Theme(
          data: AppTheme.modifiedTheme(context),
          child: LoadingOverlayProvider.builder(child: child),
        );
      },
    );
  }
}
