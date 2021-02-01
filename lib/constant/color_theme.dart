import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import 'config.dart';

class AppColor {
  static const Color primary = const Color(0xFF9efcff);
  static const Color accent = const Color(0xFFfaaa81);
  static final MaterialColor materialPrimary =
      JinColorUtils.hexColorToMaterialColor(0xFF9efcff);
  static final MaterialColor materialAccent =
      JinColorUtils.hexColorToMaterialColor(0xFFfaaa81);
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
    buttonColor: AppColor.materialPrimary,
    fontFamily: Config.EN_FONT_NAME,
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
      buttonColor: AppColor.materialPrimary,
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: Config.EN_FONT_NAME,
  );
  return base;
}
