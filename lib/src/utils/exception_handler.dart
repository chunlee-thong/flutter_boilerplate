import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry/sentry.dart';

import '../http/client/http_exception.dart';
import '../services/auth_service.dart';
import '../widgets/ui_helper.dart';
import 'custom_exception.dart';

class ExceptionHandler {
  ///Record error to Analytic or Crashlytic
  static void recordError(dynamic exception, {StackTrace? stackTrace}) {
    stackTrace ??= exception is Error ? exception.stackTrace : null;
    if (kReleaseMode) {
      Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }

  static void handleManagerError(dynamic exception, BuildContext context) {
    if (exception is! HttpRequestException) {
      recordError(exception);
    }
    if (exception is SessionExpiredException) {
      UIHelper.showToast(context, exception.toString());
      AuthService.logOutUser(context, showConfirmation: false);
    }
  }

  static Future<T?> run<T>(
    BuildContext? context,
    FutureOr<T> Function() function, {
    void Function(dynamic)? onError,
    VoidCallback? onDone,
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

      if (exception is! HttpRequestException) {
        recordError(exception, stackTrace: stackTrace);
      }

      onError?.call(exception);
      return null;
    } finally {
      onDone?.call();
    }
  }
}
