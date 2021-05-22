import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
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
    await EasyLocalization.ensureInitialized();
    registerHiveAdapter();
    registerLocator();
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
