import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import './constant/app_constant.dart';
import './api_service/mock_api_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'constant/colors.dart';
import 'pages/splash_page/splash_page.dart';

GetIt getIt = GetIt.instance;

void registerLocator() {
  getIt.registerSingleton<MockApiProvider>(MockApiProvider());
}

void main() {
  registerLocator();
  return runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [EN_LOCALE, KH_LOCALE],
      path: 'resources/language',
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Boilerplate',
      navigatorKey: JinNavigator.navigatorKey,
      theme: ThemeData(
        primarySwatch: primaryColor,
        accentColor: secondaryColor,
        fontFamily: "GoogleSans",
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      home: SplashScreenPage(),
    );
  }
}
