import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/providers/auth_provider.dart';
import 'package:flutter_boilerplate/src/utils/app_utils.dart';
import 'package:sentry/sentry.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:sura_manager/sura_manager.dart';

import '../http/client/http_exception.dart';
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
      AuthProvider.getProvider(context).logOutUser(context, showConfirmation: false);
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
      if (exception is SessionExpiredException) {
        if (context != null) {
          UIHelper.showToast(context, exception.toString());
          AuthProvider.getProvider(context).logOutUser(context, showConfirmation: false);
          return null;
        }
      }
      String errorMessage = AppUtils.getReadableErrorMessage(exception);

      if (context != null) {
        UIHelper.showErrorDialog(context, errorMessage);
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
