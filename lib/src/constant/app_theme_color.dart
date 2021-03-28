import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import 'app_config.dart';

class AppColor {
  //main
  static const Color primary = const Color(0xFF573399);
  static const Color accent = const Color(0xFFef5285);
  //other
  static const Color fbColor = const Color(0xFF3b5998);
  static const Color googleRed = const Color(0xFFDB4437);
  static const Color appleColor = const Color(0xFF555555);
  static const Color twitterColor = const Color(0xFF1DA1F2);
  //material
  static final MaterialColor materialPrimary = SuraColor.toMaterial(primary.value);
  static final MaterialColor materialAccent = SuraColor.toMaterial(accent.value);
}

final ThemeData kLightTheme = _buildLightTheme();
final ThemeData kDarkTheme = _buildDarkTheme();

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    primarySwatch: AppColor.materialPrimary,
    accentColor: AppColor.materialAccent,
    tabBarTheme: TabBarTheme(
      labelColor: AppColor.materialAccent,
      unselectedLabelColor: Colors.grey,
    ),
    buttonColor: AppColor.primary,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: AppConfig.EN_FONT_NAME,
  );
  return base;
}

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: AppColor.materialPrimary,
    primaryColorDark: AppColor.materialPrimary,
    accentColor: AppColor.materialAccent,
    toggleableActiveColor: AppColor.materialAccent,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: AppConfig.EN_FONT_NAME,
  );
  return base;
}
