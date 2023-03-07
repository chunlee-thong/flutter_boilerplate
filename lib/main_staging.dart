import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:skadi/skadi.dart';

import 'bootstrap.dart';
import 'flavor.dart';
import 'app.dart';
import 'src/core/constant/app_config.dart';
import 'src/core/utilities/exception_handler.dart';

void main() async {
  runZonedGuarded(() async {
    await App.bootstrap(Flavor.staging);
    await SentryFlutter.init(
      (options) {
        options.dsn = AppConfig.sentryDsn;
      },
      appRunner: () => runApp(const MyApp()),
    );
  }, (exception, stackTrace) async {
    errorLog("RunZonedGuard error: ", exception);
    ExceptionHandler.recordError(exception, stackTrace);
  });
}
