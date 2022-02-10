import 'package:flutter/material.dart';
import 'package:sura_manager/sura_manager.dart';

import '../http/repository/index.dart';
import '../models/response/user/user_model.dart';

class UserProvider extends ChangeNotifier {
  final FutureManager<UserModel> userManager = FutureManager<UserModel>();

  UserModel? get userData => userManager.data;

  Future<void> getUserInfo({bool throwError = false}) async {
    await userManager.asyncOperation(
      () => userRepository.fetchUserInfo(),
      reloading: true,
      throwError: throwError,
    );
  }

  @override
  void dispose() {
    userManager.dispose();
    super.dispose();
  }
}
