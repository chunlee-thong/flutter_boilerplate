import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

import '../utils/custom_exception.dart';
import '../widgets/common/ui_helper.dart';

class AppUtils {
  static void util() {}
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds = 800});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

///a function that use globally for try catch the exception, so you can easily send a report or
///do run some function on some exception
Future<T> exceptionWatcher<T>(
  FutureOr<T> Function() function, {
  BuildContext context,
}) async {
  try {
    return await function();
  } catch (exception) {
    if (exception is SessionLogoutException) {
      if (context != null) {
        UIHelper.showToast(context, exception.toString());
        AuthService.logOutUser(context, showConfirmation: false);
      }
    } else if (context != null) {
      UIHelper.showErrorDialog(context, exception);
    }
    return null;
  }
}

///Use with FutureManagerBuilder onError field to handle error
void handleManagerError(dynamic exception, BuildContext context) {
  if (exception is SessionLogoutException) {
    UIHelper.showToast(context, exception.toString());
    AuthService.logOutUser(context, showConfirmation: false);
  }
}
