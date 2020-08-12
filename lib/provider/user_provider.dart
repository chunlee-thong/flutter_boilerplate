import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void setLoginStatus(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}
