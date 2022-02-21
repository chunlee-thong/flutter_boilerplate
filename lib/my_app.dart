import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '/src/constant/app_theme_color.dart';
import '/src/utils/exception_handler.dart';
import 'src/constant/app_config.dart';
import 'src/constant/app_locale.dart';
import 'src/pages/splash/splash_page.dart';
import 'src/providers/auth_provider.dart';
import 'src/providers/loading_overlay_provider.dart';
import 'src/providers/theme_provider.dart';
import 'src/providers/user_provider.dart';
import 'src/widgets/state_widgets/error_widget.dart';
import 'src/widgets/state_widgets/loading_widget.dart';

///This widget can change to use your app name
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Locale> languages = KAppLanguages.map((lang) => lang.locale).toList();

  @override
  Widget build(BuildContext context) {
    const bool useDevicePreview = false;
    return DevicePreview(
      enabled: useDevicePreview,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => LoadingOverlayProvider()),
        ],
        child: EasyLocalization(
          path: AppConfig.languageAssetPath,
          supportedLocales: languages,
          fallbackLocale: EN_LOCALE,
          startLocale: EN_LOCALE,
          child: Builder(
            builder: (context) => Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return SuraProvider(
                  loadingWidget: const LoadingWidget(),
                  onFutureManagerError: ExceptionHandler.handleManagerError,
                  errorWidget: (error, onRefresh) {
                    return CustomErrorWidget(
                      message: error,
                      onRefresh: onRefresh,
                    );
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
                      ErrorWidget.builder = (detail) {
                        if (kReleaseMode) {
                          return const FlutterCustomErrorRendering();
                        }
                        return ErrorWidget(detail.exception);
                      };
                      return _AppWrapper(child: child!);
                    },
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
    LoadingOverlayProvider.init(context);
    return SuraResponsiveBuilder(
      builder: (context) {
        return Theme(
          data: AppTheme.modifiedTheme(context),
          child: Stack(
            children: [
              child,
              _buildGlobalOverlayLoading(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGlobalOverlayLoading() {
    return Consumer<LoadingOverlayProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Container(
            child: const Center(child: CircularProgressIndicator()),
            color: Colors.black26,
          );
        }
        return emptySizedBox;
      },
    );
  }
}
