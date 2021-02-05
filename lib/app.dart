import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:provider/provider.dart';

import './api_service/http_client.dart';
import 'constant/app_config.dart';
import 'constant/app_constant.dart';
import 'constant/app_theme_color.dart';
import 'pages/splash/splash_page.dart';
import 'providers/theme_provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Locale> languages = APP_LOCALES.map((lang) => lang.locale).toList();
  @override
  void initState() {
    BaseHttpClient.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: AppConfig.LANGUAGE_PATH,
      supportedLocales: languages,
      fallbackLocale: languages.first,
      startLocale: languages.first,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: Builder(
          builder: (context) => Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: AppConfig.APP_NAME,
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
