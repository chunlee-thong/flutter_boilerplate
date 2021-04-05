import 'dart:async';

import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/common/ui_helper.dart';

///a function that use globally for try catch the exception, so you can easily send a report or
///do run some function on some exception
Future<T> exceptionWatcher<T>(
  ///context can be null
  BuildContext context,
  FutureOr<T> Function() function, {
  VoidCallback onDone,
}) async {
  try {
    return await function();
  } on UserCancelException catch (_) {
    return null;
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
  } finally {
    onDone?.call();
  }
}

///Use with FutureManagerBuilder onError field to handle error
void handleManagerError(dynamic exception, BuildContext context) {
  if (exception is SessionLogoutException) {
    UIHelper.showToast(context, exception.toString());
    AuthService.logOutUser(context, showConfirmation: false);
  }
}

///Other custom exception
class UserCancelException {
  @override
  String toString() {
    return "User cancel operation, No need to do anything";
  }
}

class SessionLogoutException {
  @override
  String toString() {
    return "Session expired, Please login again";
  }
}
