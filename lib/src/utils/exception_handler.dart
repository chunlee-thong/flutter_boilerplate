import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../http/client/http_exception.dart';
import '../providers/auth_provider.dart';
import '../providers/index.dart';
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

  static void handleManagerError(FutureManagerError error, BuildContext context) {
    if (error.stackTrace != null) {
      errorLog(error.stackTrace);
    }
    if (error.exception is! HttpRequestException) {
      recordError(error.exception, stackTrace: error.stackTrace);
    }

    if (error.exception is SessionExpiredException) {
      UIHelper.showToast(context, error.toString());
      readProvider<AuthProvider>(context).logOutUser(context, showConfirmation: false);
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
      errorLog(stackTrace);
      if (exception is SessionExpiredException) {
        if (context != null) {
          UIHelper.showToast(context, exception.toString());
          readProvider<AuthProvider>(context).logOutUser(context, showConfirmation: false);
          return null;
        }
      }

      if (context != null) {
        UIHelper.showErrorDialog(context, exception);
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
