import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'bootstrap.dart';
import 'flavor.dart';
import 'my_app.dart';
import 'src/constant/app_config.dart';

Future main() async {
  await App.bootstrap(Flavor.dev);
  await SentryFlutter.init(
    (options) {
      options.dsn = AppConfig.sentryDsn;
    },
    appRunner: () => runApp(const MyApp()),
  );
}
