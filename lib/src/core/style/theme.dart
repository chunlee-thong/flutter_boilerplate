import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

import '../constant/app_config.dart';
import '../constant/app_locale.dart';
import 'color.dart';

class AppTheme {
  ///Change font family base on App's locale
  static ThemeData _customizeFontFamily(BuildContext context) {
    String fontName = context.locale == khLocale ? AppConfig.khFontName : AppConfig.enFontName;
    return Theme.of(context).copyWith(
      textTheme: Theme.of(context).textTheme.apply(fontFamily: fontName),
    );
  }

  ///Modified current theme after default theme has been set
  static ThemeData modifiedTheme(BuildContext context) {
    final ThemeData newTheme = _customizeFontFamily(context);
    return newTheme.copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            64,
            SkadiResponsive.value(40, 54, 64),
          ),
        ),
      ),
      textTheme: newTheme.textTheme.copyWith(
        labelLarge: newTheme.textTheme.labelLarge?.responsiveFontSize,
        titleMedium: newTheme.textTheme.titleMedium?.responsiveFontSize,
        titleSmall: newTheme.textTheme.titleSmall?.responsiveFontSize,
        bodyMedium: newTheme.textTheme.bodyMedium?.responsiveFontSize,
        bodySmall: newTheme.textTheme.bodySmall?.responsiveFontSize,
      ),
      appBarTheme: newTheme.appBarTheme.copyWith(
        titleTextStyle: newTheme.textTheme.titleLarge?.responsiveFontSize,
      ),
    );
  }

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
          foregroundColor: Colors.white,
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

    //Modified AppBar Theme base on existing Theme
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
