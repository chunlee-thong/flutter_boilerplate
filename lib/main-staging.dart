import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';

import 'app.dart';
import 'flavors.dart';
import 'main-dev.dart';
import 'src/utils/logger.dart';

void main() async {
  runZonedGuarded(() async {
    await registerAppConfiguration();
    setupStagingEnvConfig();
    await Sentry.init(
      (options) {
        options.dsn = 'sentry-dns';
      },
      appRunner: () => runApp(MyApp()),
    );
  }, (exception, stackTrace) async {
    errorLog("RunZonedGuard error: ", exception);
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}
