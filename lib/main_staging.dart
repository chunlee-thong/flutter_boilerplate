import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sura_flutter/sura_flutter.dart';

import 'bootstrap.dart';
import 'flavor.dart';
import 'my_app.dart';
import 'src/constant/app_config.dart';
import 'src/utils/exception_handler.dart';

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
    ExceptionHandler.recordError(exception, stackTrace: stackTrace);
  });
}
