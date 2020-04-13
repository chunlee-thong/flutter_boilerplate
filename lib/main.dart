import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/pages/splash_page/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

import 'constant/colors.dart';
import 'pages/splash_page/splash_page.dart';

GetIt getIt = GetIt.instance;

void registerLocator() {
  //getIt.registerSingleton<DummyModel>(DummyModel());
}

void main() {
  registerLocator();
  return runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [Locale('en', 'US'), Locale('km', 'KH')],
      path: 'resources/language',
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Boilerplate',
      theme: ThemeData(
        primarySwatch: primaryColor,
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
