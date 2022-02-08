import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app.dart';
import 'flavor.dart';
import 'my_app.dart';
import 'src/utils/logger.dart';

void main() async {
  runZonedGuarded(() async {
    setupFlavorConfiguration(Flavor.dev);
    await App.init();
    await SentryFlutter.init(
      (options) {
        options.dsn = 'https://e2af85f7d13e4c12a244a33b2941c59e@glitchtip.lynical.com/1';
      },
      appRunner: () => runApp(const MyApp()),
    );
  }, (exception, stackTrace) async {
    errorLog("RunZonedGuard error: ", exception);
  });
}
