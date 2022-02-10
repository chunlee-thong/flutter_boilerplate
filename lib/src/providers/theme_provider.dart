import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String THEME_KEY = "key.theme";

///Control Theme in our app, default theme is Light
class ThemeProvider extends ChangeNotifier {
  static bool _isDark = false;
  static bool get isDark => _isDark;

  static final List<String> themeValueString = ["dark", "light"];

  static ThemeProvider getProvider(BuildContext context) => Provider.of<ThemeProvider>(context, listen: false);

  static SharedPreferences? spf;

  static Future<void> initializeTheme() async {
    spf = await SharedPreferences.getInstance();
    var systemBrightness = SchedulerBinding.instance!.window.platformBrightness.name;
    String savedTheme = spf?.getString(THEME_KEY) ?? systemBrightness;
    _isDark = _themeStringChecker(savedTheme);
  }

  T themeValue<T>(T lightValue, T darkValue) {
    return isDark ? darkValue : lightValue;
  }

  void switchTheme([bool? isDarkTheme]) async {
    //Change by provided theme or else switch between light or dark
    _isDark = isDarkTheme ?? !isDark;
    spf?.setString(THEME_KEY, isDark ? themeValueString[0] : themeValueString[1]);
    notifyListeners();
  }

  static bool _themeStringChecker(String value) {
    if (value == themeValueString[0]) return true;
    if (value == themeValueString[1]) return false;
    return false;
  }
}
