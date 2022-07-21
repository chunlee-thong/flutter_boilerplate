import 'package:flutter_boilerplate/src/core/mixin/index.dart';
import 'package:future_manager/future_manager.dart';

import '../models/response/user/user_model.dart';
import '../repositories/index.dart';

class UserController extends RequiredDisposeMixin {
  final FutureManager<UserModel> userManager = FutureManager<UserModel>();

  UserModel? get userData => userManager.data;

  Future<void> getUserInfo({bool throwError = false}) async {
    await userManager.execute(
      () => userRepository.fetchUserInfo(),
      reloading: true,
      throwError: throwError,
    );
  }

  @override
  void dispose() {
    userManager.dispose();
  }
}
