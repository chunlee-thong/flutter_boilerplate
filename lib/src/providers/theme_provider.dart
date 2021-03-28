import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../services/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  static ThemeProvider getProvider(BuildContext context) => Provider.of<ThemeProvider>(context, listen: false);

  void initializeTheme() {
    bool isDark = LocalStorage.sp.getBool(THEME_KEY) ?? false;
    _isDarkTheme = isDark;
    notifyListeners();
  }

  T themeValue<T>(T lightValue, T darkValue) {
    return isDarkTheme ? darkValue : lightValue;
  }

  void switchTheme() async {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
    LocalStorage.sp.setBool(THEME_KEY, _isDarkTheme);
  }
}
