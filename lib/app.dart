import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';

import './src/constant/app_config.dart';
import './src/constant/app_constant.dart';
import './src/constant/app_theme_color.dart';
import './src/pages/splash/splash_page.dart';
import './src/providers/theme_provider.dart';
import './src/providers/user_provider.dart';
import './src/widgets/state_widgets/loading_widget.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Locale> languages = APP_LOCALES.map((lang) => lang.locale).toList();
  @override
  void initState() {
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
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: Builder(
          builder: (context) => Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return SuraTheme(
                loadingWidget: LoadingWidget(),
                child: MaterialApp(
                  title: AppConfig.APP_NAME,
                  navigatorKey: SuraNavigator.navigatorKey,
                  theme: themeProvider.isDarkTheme ? kDarkTheme : kLightTheme,
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  home: SplashScreenPage(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
