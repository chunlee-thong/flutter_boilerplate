import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry/sentry.dart';

import 'app.dart';
import 'flavors.dart';
import 'src/services/local_storage_service/fss_storage_service.dart';
import 'src/providers/theme_provider.dart';
import 'src/services/local_storage_service/local_storage_service.dart';
import 'src/utils/hive_db_adapter.dart';
import 'src/utils/logger.dart';
import 'src/utils/service_locator.dart';

void main() async {
  runZonedGuarded(() async {
    await registerAppConfiguration();
    setupDevEnvConfig();
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

Future registerAppConfiguration() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await EasyLocalization.ensureInitialized();
  await LocalStorage.initialize(FssStorageService());
  await ThemeProvider.initializeTheme();
  registerHiveAdapter();
  registerLocator();
}
