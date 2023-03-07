import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:skadi/skadi.dart';

import '../../controllers/auth_controller.dart';
import '../../models/response/user/user_model.dart';
import '../../widgets/ui_helper.dart';
import '../http/http_exception.dart';
import 'custom_exception.dart';

enum ErrorWidgetType {
  dialog,
  toast,
}

abstract class ExceptionHandler {
  ExceptionHandler._();

  static Future<T?> run<T>(
    BuildContext? context,
    FutureOr<T> Function() function, {
    void Function(dynamic)? onError,
    ErrorWidgetType errorType = ErrorWidgetType.toast,
    VoidCallback? onDone,
  }) async {
    try {
      return await function();
    } on UserCancelException catch (_) {
      return null;
    } catch (exception, stackTrace) {
      if (exception is SessionExpiredException) {
        if (context != null) {
          UIHelper.showToast(context, exception.message);
          context.read<AuthController>().logOutUser(context, showConfirmation: false);
          return null;
        }
      }

      if (context != null) {
        if (errorType == ErrorWidgetType.toast) {
          UIHelper.showErrorToast(
            context,
            exception,
            position: ToastPosition.bottom,
          );
        } else {
          UIHelper.showErrorDialog(
            context,
            exception,
          );
        }
      }
      recordError(exception, stackTrace);
      onError?.call(exception);
      return null;
    } finally {
      onDone?.call();
    }
  }

  ///Record error to Analytic or Crashlytic
  static void recordError(dynamic exception, [StackTrace? stackTrace]) {
    errorLog(exception, stackTrace);
    bool condition = exception is! HttpRequestException;
    stackTrace ??= exception is Error ? exception.stackTrace : null;
    if (kReleaseMode && condition) {
      Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  static void configScope(UserModel user) async {
    await Sentry.configureScope((scope) {
      SentryUser sentryUser = SentryUser(
        id: user.id,
        email: user.email,
      );
      scope.setUser(sentryUser);
    });
  }

  static void handleManagerError(FutureManagerError error, BuildContext context) {
    recordError(error.exception, error.stackTrace);
    if (error.exception is SessionExpiredException) {
      UIHelper.showToast(context, error.exception.toString());
      context.read<AuthController>().logOutUser(context, showConfirmation: false);
    }
  }
}
