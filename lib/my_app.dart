import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';

import 'src/constant/app_config.dart';
import 'src/constant/app_locale.dart';
import 'src/http/client/http_exception.dart';
import 'src/pages/splash/splash_page.dart';
import 'src/providers/auth_provider.dart';
import 'src/providers/theme_provider.dart';
import 'src/providers/user_provider.dart';
import 'src/services/auth_service.dart';
import 'src/widgets/responsive_size.dart';
import 'src/widgets/state_widgets/error_widget.dart';
import 'src/widgets/state_widgets/loading_overlay.dart';
import 'src/widgets/state_widgets/loading_widget.dart';

///This widget can change to use your app name
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Locale> languages = KAppLanguages.map((lang) => lang.locale).toList();

  ///Change font family base on locale
  ThemeData _customizeTheme(BuildContext context) {
    String fontName = context.locale == KH_LOCALE ? AppConfig.khFontName : AppConfig.enFontName;
    return Theme.of(context).copyWith(
      textTheme: Theme.of(context).textTheme.apply(fontFamily: fontName),
    );
  }

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
        ],
        child: EasyLocalization(
          path: AppConfig.languageAssetPath,
          supportedLocales: languages,
          fallbackLocale: KH_LOCALE,
          startLocale: KH_LOCALE,
          child: Builder(
            builder: (context) => Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return SuraProvider(
                  loadingWidget: const LoadingWidget(),
                  onFutureManagerError: (error, context) {
                    if (error is SessionExpiredException) {
                      AuthService.logOutUser(context, showConfirmation: false);
                    }
                  },
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
                    theme: themeProvider.getThemeData,
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    builder: (context, child) {
                      ErrorWidget.builder = (detail) {
                        if (kReleaseMode) {
                          return const FlutterCustomErrorRendering();
                        }
                        return ErrorWidget(detail.exception);
                      };
                      return Theme(
                        child: ResponsiveBuilder(
                          child: LoadingOverlay(child: child!),
                        ),
                        data: _customizeTheme(context),
                      );
                    },
                    home: const SplashScreenPage(),
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
