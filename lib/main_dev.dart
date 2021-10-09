import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';

import 'app.dart';
import 'flavor.dart';
import 'src/utils/logger.dart';

void main() async {
  runZonedGuarded(() async {
    setupFlavorConfiguration(Flavor.dev);
    await registerAppConfiguration();
    await Sentry.init(
      (options) {
        options.dsn = 'sentry-dns';
      },
      appRunner: () => runApp(const MyApp()),
    );
  }, (exception, stackTrace) async {
    errorLog("RunZonedGuard error: ", exception);
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}
