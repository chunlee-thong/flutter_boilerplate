import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry/sentry.dart';

import './src/utils/hive_db_adapter.dart';
import './src/utils/service_locator.dart';
import 'app.dart';
import 'flavors.dart';
import 'src/utils/logger.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    registerHiveAdapter();
    registerLocator();
    setupDevEnvConfig();
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
