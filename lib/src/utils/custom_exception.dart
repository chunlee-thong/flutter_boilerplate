import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry/sentry.dart';

import '../services/auth_service.dart';
import '../ui/widgets/common/ui_helper.dart';

///a function that use globally for try catch the exception, so you can easily send a report or
///do run some function on some exception
///Return null if there is an exception
Future<T?> ExceptionWatcher<T>(
  ///context can be null
  BuildContext? context,
  FutureOr<T> Function() function, {
  VoidCallback? onDone,
  void Function(dynamic)? onError,
}) async {
  try {
    return await function();
  } on UserCancelException catch (_) {
    return null;
  } catch (exception, stackTrace) {
    String? message = "";
    if (exception is SessionExpiredException) {
      if (context != null) {
        UIHelper.showToast(context, exception.toString());
        AuthService.logOutUser(context, showConfirmation: false);
      }
    } else if (exception is PlatformException) {
      message = exception.message;
    } else if (exception is FirebaseAuthException) {
      message = exception.message;
      if (exception.code == 'invalid-verification-code') {
        message = "Invalid Code";
      }
    } else if (exception is TypeError) {
      message = exception.toString();
    } else {
      message = exception.toString();
    }
    Sentry.captureException(message, stackTrace: stackTrace);
    if (context != null) {
      UIHelper.showErrorDialog(context, message);
    }
    onError?.call(exception);
    return null;
  } finally {
    onDone?.call();
  }
}

void handleManagerError(dynamic exception, BuildContext context) {
  if (exception is SessionExpiredException) {
    UIHelper.showToast(context, exception.toString());
    AuthService.logOutUser(context, showConfirmation: false);
  }
}

class UserCancelException {
  @override
  String toString() {
    return "User cancel operation, No need to do anything";
  }
}

class SessionExpiredException {
  @override
  String toString() {
    return "Session expired, Please login again";
  }
}
