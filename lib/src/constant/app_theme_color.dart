import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import 'app_config.dart';

class AppColor {
  //main
  static const Color primary = Color(0xFFE94C89);
  static const Color accent = Color(0xFF2F3193);
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
  static ThemeData primaryTheme(bool isDark) {
    final Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    final Color textFieldFilledColor = isDark ? Colors.white12 : const Color(0xFFDADADA);

    ThemeData theme = ThemeData(
      primaryColor: AppColor.primary,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColor.materialPrimary,
        brightness: brightness,
        accentColor: AppColor.googleRed,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: AppColor.materialAccent,
        unselectedLabelColor: Colors.grey,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColor.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      fontFamily: AppConfig.enFontName,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: textFieldFilledColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    theme = theme.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.textTheme.bodyText1?.color,
      ),
    );
    return theme;
  }
}
