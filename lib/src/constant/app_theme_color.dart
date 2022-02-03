import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import 'app_config.dart';

class AppColor {
  //main
  static const Color primary = Color(0xFF573399);
  static const Color accent = Color(0xFFef5285);
  //other
  static const Color fbColor = Color(0xFF3b5998);
  static const Color googleRed = Color(0xFFDB4437);
  static const Color appleColor = Color(0xFF555555);
  static const Color twitterColor = Color(0xFF1DA1F2);
  //material
  static final MaterialColor materialPrimary = SuraColor.toMaterial(primary.value);
  static final MaterialColor materialAccent = SuraColor.toMaterial(accent.value);
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    tabBarTheme: TabBarTheme(
      labelColor: AppColor.materialAccent,
      unselectedLabelColor: Colors.grey,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColor.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: AppConfig.enFontName,
    colorScheme: const ColorScheme.light(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColorDark: AppColor.materialPrimary,
    toggleableActiveColor: AppColor.materialAccent,
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColor.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    fontFamily: AppConfig.enFontName,
    colorScheme: const ColorScheme.dark(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
      ),
    ),
  );
}
