import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api_service/index.dart';
import '../models/response/user/user_model.dart';
import '../services/async_future_controller.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  AsyncFutureController<UserModel> userController = AsyncFutureController<UserModel>();

  UserModel get userData => userController.data;

  static UserProvider getProvider(BuildContext context, [bool listen = false]) => Provider.of(context, listen: listen);

  void setLoginStatus(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  Future<void> getUserInfo() async {
    userController.asyncOperation(
      () => userApiService.fetchUserInfo(),
      reloading: true,
    );
  }
}
