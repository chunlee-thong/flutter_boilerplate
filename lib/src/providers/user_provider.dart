import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sura_manager/sura_manager.dart';

import '../api/index.dart';
import '../models/response/user/user_model.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  final FutureManager<UserModel> userManager = FutureManager<UserModel>();

  UserModel? get userData => userManager.data;

  static UserProvider getProvider(BuildContext context,
          [bool listen = false]) =>
      Provider.of<UserProvider>(
        context,
        listen: listen,
      );

  void setLoginStatus(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  Future<void> getUserInfo() async {
    await userManager.asyncOperation(
      () => userRepository.fetchUserInfo(),
      reloading: true,
    );
  }

  @override
  void dispose() {
    userManager.dispose();
    super.dispose();
  }
}
