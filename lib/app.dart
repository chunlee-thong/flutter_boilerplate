import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:provider/provider.dart';

import 'constant/app_constant.dart';
import 'constant/color_theme.dart';
import 'constant/config.dart';
import 'pages/splash_page/splash_page.dart';
import 'provider/theme_provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: [EN_LOCALE, KH_LOCALE],
      path: AppConstant.LANGUAGE_PATH,
      fallbackLocale: EN_LOCALE,
      startLocale: EN_LOCALE,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: Builder(
          builder: (context) => Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: Config.APP_NAME,
                navigatorKey: JinNavigator.navigatorKey,
                theme: themeProvider.isDarkTheme ? kDarkTheme : kLightTheme,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                home: SplashScreenPage(),
              );
            },
          ),
        ),
      ),
    );
  }
}
