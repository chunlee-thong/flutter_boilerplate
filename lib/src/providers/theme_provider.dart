import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeProvider readThemeProvider(BuildContext context) => Provider.of<ThemeProvider>(context, listen: false);

class ThemeProvider extends ChangeNotifier {
  static bool _isDark = false;
  static bool get isDark => _isDark;

  static final List<String> themeValueString = ["dark", "light"];

  static SharedPreferences? spf;
  static const String _THEME_KEY = "key.theme";

  ///Intialize this method at main function to immediately get system brightness
  static Future<void> initializeTheme() async {
    spf = await SharedPreferences.getInstance();
    var systemBrightness = SchedulerBinding.instance!.window.platformBrightness.name;
    String savedTheme = spf?.getString(_THEME_KEY) ?? systemBrightness;
    _isDark = _themeStringChecker(savedTheme);
  }

  //Get value according to current theme value
  T themeValue<T>(T lightValue, T darkValue) {
    return isDark ? darkValue : lightValue;
  }

  void switchTheme([bool? isDarkTheme]) async {
    //Change by provided theme or else switch between light or dark
    _isDark = isDarkTheme ?? !isDark;
    spf?.setString(_THEME_KEY, isDark ? themeValueString[0] : themeValueString[1]);
    notifyListeners();
  }

  static bool _themeStringChecker(String value) {
    if (value == themeValueString[0]) return true;
    if (value == themeValueString[1]) return false;
    return false;
  }
}
