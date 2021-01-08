import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import 'config.dart';

class AppColor {
  static final MaterialColor primaryColor =
      JinColorUtils.hexColorToMaterialColor(0xFF9efcff);
  static final MaterialColor accentColor =
      JinColorUtils.hexColorToMaterialColor(0xFFfaaa81);
}

final ThemeData kLightTheme = _buildLightTheme();
final ThemeData kDarkTheme = _buildDarkTheme();

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    primarySwatch: AppColor.primaryColor,
    accentColor: AppColor.accentColor,
    tabBarTheme: TabBarTheme(
      labelColor: AppColor.accentColor,
      unselectedLabelColor: Colors.grey,
    ),
    buttonColor: AppColor.primaryColor,
    fontFamily: Config.EN_FONT_NAME,
  );
  return base;
}

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: AppColor.primaryColor,
    primaryColorDark: AppColor.primaryColor,
    accentColor: AppColor.accentColor,
    toggleableActiveColor: AppColor.accentColor,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: Config.EN_FONT_NAME,
  );
  return base;
}
