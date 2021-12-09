import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry/sentry.dart';

import '../http/client/http_exception.dart';
import '../services/auth_service.dart';
import '../widgets/ui_helper.dart';
import 'custom_exception.dart';

class ExceptionHandler {
  ///Record error to Analytic or Crashlytic
  static void recordError({required String message, dynamic stackTrace}) {
    Sentry.captureException(message, stackTrace: stackTrace);
  }

  static Future<T?> run<T>(
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
      String message = "";
      if (exception is SessionExpiredException) {
        if (context != null) {
          UIHelper.showToast(context, exception.toString());
          AuthService.logOutUser(context, showConfirmation: false);
        }
      } else if (exception is PlatformException) {
        message = exception.message ?? exception.toString();
      } else {
        message = exception.toString();
      }

      if (context != null) {
        UIHelper.showErrorDialog(context, message);
      }

      ExceptionHandler.recordError(
        message: message,
        stackTrace: stackTrace,
      );
      onError?.call(exception);
      return null;
    } finally {
      onDone?.call();
    }
  }
}

///a function that use globally for try catch the exception, so you can easily send a report or
///do run some function on some exception
///Return null if there is an exception

///Use this function on your AsyncSubjectManager or FutureManager
///To run some logic when there is an error
void handleManagerError(dynamic exception, BuildContext context) {
  if (exception is SessionExpiredException) {
    UIHelper.showToast(context, exception.toString());
    AuthService.logOutUser(context, showConfirmation: false);
  }
  ExceptionHandler.recordError(
    message: exception.toString(),
    stackTrace: exception.stackTrace,
  );
}
