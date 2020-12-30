import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/constant/theme.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import './constant/app_constant.dart';
import './constant/config.dart';
import './utils/hive_db_adapter.dart';
import './utils/service_locator.dart';
import 'pages/splash_page/splash_page.dart';

void main() async {
  await Hive.initFlutter();
  registerHiveAdapter();
  registerLocator();
  return runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [EN_LOCALE, KH_LOCALE],
      path: AppConstant.LANGUAGE_PATH,
      fallbackLocale: EN_LOCALE,
      startLocale: EN_LOCALE,
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.APP_NAME,
      navigatorKey: JinNavigator.navigatorKey,
      theme: kLightTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: SplashScreenPage(),
      //Dynamically change font by language
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: context.locale == KH_LOCALE
                      ? Config.KH_FONT_NAME
                      : Config.EN_FONT_NAME,
                  fontSizeFactor: 1.0,
                ),
          ),
          child: child,
        );
      },
    );
  }
}
