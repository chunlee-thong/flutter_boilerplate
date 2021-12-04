import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../constant/app_theme_color.dart';
import '../services/local_storage_service/local_storage_service.dart';

///Control Theme in our app, default theme is Light
class ThemeProvider extends ChangeNotifier {
  static bool isDark = false;

  static final List<String> themeValueString = ["dark", "light"];

  static ThemeProvider getProvider(BuildContext context) => Provider.of<ThemeProvider>(context, listen: false);

  static Future initializeTheme() async {
    var systemBrightness = describeEnum(SchedulerBinding.instance!.window.platformBrightness);
    String savedTheme = await LocalStorage.read(key: THEME_KEY) ?? systemBrightness;
    isDark = _themeStringChecker(savedTheme);
  }

  T themeValue<T>(T lightValue, T darkValue) {
    return isDark ? darkValue : lightValue;
  }

  void switchTheme([bool? isDarkTheme]) async {
    //Change by provided theme or else switch between light or dark
    isDark = isDarkTheme ?? !isDark;
    notifyListeners();
    LocalStorage.write(key: THEME_KEY, value: isDark ? themeValueString[0] : themeValueString[1]);
  }

  ThemeData get getThemeData => isDark ? AppTheme.darkTheme : AppTheme.lightTheme;

  static bool _themeStringChecker(String value) {
    if (value == themeValueString[0]) return true;
    if (value == themeValueString[1]) return false;
    return false;
  }
}
