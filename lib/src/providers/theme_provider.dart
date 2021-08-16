import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import '../constant/app_theme_color.dart';
import '../services/local_storage_service/local_storage_service.dart';

enum MyThemeValue {
  dark,
  light,
}

///Control Theme in our app, default theme is Light
class ThemeProvider extends ChangeNotifier {
  static MyThemeValue _theme = MyThemeValue.light;
  MyThemeValue get theme => _theme;

  static ThemeProvider getProvider(BuildContext context) =>
      Provider.of<ThemeProvider>(context, listen: false);

  static Future initializeTheme() async {
    var systemBrightness =
        describeEnum(SchedulerBinding.instance!.window.platformBrightness);
    String savedTheme =
        await LocalStorage.read(key: THEME_KEY) ?? systemBrightness;
    _theme = _themeStringToEnum(savedTheme);
  }

  T themeValue<T>(T lightValue, T darkValue) {
    return _theme == MyThemeValue.dark ? darkValue : lightValue;
  }

  void switchTheme([MyThemeValue? themeValue]) async {
    //Change by provided theme or else switch between light or dark
    _theme = themeValue ??
        (_theme == MyThemeValue.light ? MyThemeValue.dark : MyThemeValue.light);
    notifyListeners();
    LocalStorage.write(
        key: THEME_KEY, value: _theme.toString().split(".").last);
  }

  ThemeData getThemeData() {
    if (_theme == MyThemeValue.dark) return kDarkTheme;
    if (_theme == MyThemeValue.light) return kLightTheme;
    return kLightTheme;
  }

  static MyThemeValue _themeStringToEnum(String value) {
    if (value == "dark") return MyThemeValue.dark;
    if (value == "light") return MyThemeValue.light;
    return MyThemeValue.light;
  }
}
