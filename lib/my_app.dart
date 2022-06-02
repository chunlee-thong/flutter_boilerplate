import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:sura_manager/sura_manager.dart';

import 'src/constant/app_config.dart';
import 'src/constant/app_locale.dart';
import 'src/constant/app_theme_color.dart';
import 'src/pages/splash/splash_page.dart';
import 'src/providers/auth_provider.dart';
import 'src/providers/theme_provider.dart';
import 'src/providers/user_provider.dart';
import 'src/utils/exception_handler.dart';
import 'src/widgets/state_widgets/error_widget.dart';
import 'src/widgets/state_widgets/loading_widget.dart';

///This widget can change to use your app name
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
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider(userProvider: context.read<UserProvider>())),
        ],
        child: EasyLocalization(
          path: AppConfig.languageAssetPath,
          supportedLocales: languages,
          fallbackLocale: enLocale,
          startLocale: enLocale,
          child: Builder(
            builder: (context) => Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return SuraManagerProvider(
                  onFutureManagerError: ExceptionHandler.handleManagerError,
                  errorBuilder: (error, onRefresh) {
                    return CustomErrorWidget(
                      error: error,
                      onRefresh: onRefresh,
                    );
                  },
                  child: SuraProvider(
                    loadingWidget: const LoadingWidget(),
                    errorWidget: (error, context) {
                      return CustomErrorWidget(error: error);
                    },
                    child: MaterialApp(
                      useInheritedMediaQuery: useDevicePreview,
                      title: AppConfig.appName,
                      navigatorKey: SuraNavigator.navigatorKey,
                      theme: AppTheme.primaryTheme(ThemeProvider.isDark),
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
    );
  }
}

class _AppWrapper extends StatelessWidget {
  final Widget child;
  const _AppWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuraResponsiveBuilder(
      builder: (context) {
        return Theme(
          data: AppTheme.modifiedTheme(context),
          child: LoadingOverlayBuilder(child: child),
        );
      },
    );
  }
}
