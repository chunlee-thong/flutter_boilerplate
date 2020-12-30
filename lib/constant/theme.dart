import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import 'config.dart';

class AppColor {
  static final MaterialColor primaryColor =
      JinColorUtils.hexColorToMaterialColor(0xFF9efcff);
  static final MaterialColor secondaryColor =
      JinColorUtils.hexColorToMaterialColor(0xFFfaaa81);
}

final ThemeData kLightTheme = _buildLightTheme();
final ThemeData kDarkTheme = _buildDarkTheme();

ThemeData _buildLightTheme() {
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: AppColor.primaryColor,
    secondary: AppColor.secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: AppColor.primaryColor,
    buttonColor: AppColor.primaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: AppColor.secondaryColor,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    accentColor: AppColor.secondaryColor,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: Config.EN_FONT_NAME,
  );
  return base;
}

ThemeData _buildDarkTheme() {
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: AppColor.primaryColor,
    secondary: AppColor.primaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    primaryColor: AppColor.secondaryColor,
    cardColor: Color(0xFF121A26),
    primaryColorDark: const Color(0xFF0050a0),
    primaryColorLight: AppColor.secondaryColor,
    buttonColor: AppColor.secondaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: AppColor.secondaryColor,
    accentColor: AppColor.secondaryColor,
    canvasColor: const Color(0xFF2A4058),
    scaffoldBackgroundColor: const Color(0xFF121A26),
    backgroundColor: const Color(0xFF0D1520),
    errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: Config.EN_FONT_NAME,
  );
  return base;
}
