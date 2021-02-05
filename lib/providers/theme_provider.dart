import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../services/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  static ThemeProvider getProvider(BuildContext context) => Provider.of<ThemeProvider>(context, listen: false);

  void initializeTheme() {
    bool isDark = LocalStorage.sharedPreferences.getBool(LocalStorage.THEME_KEY) ?? false;
    _isDarkTheme = isDark;
    notifyListeners();
  }

  void switchTheme() async {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
    LocalStorage.sharedPreferences.setBool(LocalStorage.THEME_KEY, _isDarkTheme);
  }
}
