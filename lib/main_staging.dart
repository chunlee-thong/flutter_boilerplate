import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sura_flutter/sura_flutter.dart';

import 'app.dart';
import 'flavor.dart';
import 'my_app.dart';
import 'src/utils/exception_handler.dart';

void main() async {
  runZonedGuarded(() async {
    setupFlavorConfiguration(Flavor.staging);
    await App.init();
    await SentryFlutter.init(
      (options) {
        options.dsn = 'sentry-dns';
      },
      appRunner: () => runApp(const MyApp()),
    );
  }, (exception, stackTrace) async {
    errorLog("RunZonedGuard error: ", exception);
    ExceptionHandler.recordError(exception, stackTrace: stackTrace);
  });
}
