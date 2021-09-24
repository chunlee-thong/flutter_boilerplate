import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  bool _authenticated = false;

  bool get authenticated => _authenticated;

  static AuthProvider getProvider(BuildContext context, [bool listen = false]) {
    return Provider.of<AuthProvider>(context, listen: listen);
  }

  void setLoginStatus(bool status) {
    _authenticated = status;
    notifyListeners();
  }
}
