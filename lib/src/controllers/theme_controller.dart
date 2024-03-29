import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  static bool _isDark = false;
  static bool get isDark => _isDark;

  static const List<String> _themeValueString = ["dark", "light"];
  static const String kThemeKey = "key.theme";

  static late SharedPreferences _spf;

  ///Intialize this method at main function to immediately get system brightness
  static Future<void> initializeTheme() async {
    _spf = await SharedPreferences.getInstance();
    var systemBrightness = PlatformDispatcher.instance.platformBrightness.name;
    String savedTheme = _spf.getString(kThemeKey) ?? systemBrightness;
    _isDark = _themeStringChecker(savedTheme);
  }

  //Get value according to current theme value
  T themeValue<T>(T lightValue, T darkValue) {
    return isDark ? darkValue : lightValue;
  }

  void switchTheme([bool? isDarkTheme]) async {
    //Change by provided theme or else switch between light or dark
    _isDark = isDarkTheme ?? !isDark;
    _spf.setString(kThemeKey, isDark ? _themeValueString[0] : _themeValueString[1]);
    notifyListeners();
  }

  ///Convert theme brightness string to bool because systemBrightness from Flutter framework is a string
  static bool _themeStringChecker(String value) {
    if (value == _themeValueString[0]) return true;
    return false;
  }
}
