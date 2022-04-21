import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'bootstrap.dart';
import 'flavor.dart';
import 'my_app.dart';

Future main() async {
  setupFlavorConfiguration(Flavor.dev);
  await App.bootstrap();
  await SentryFlutter.init(
    (options) {
      options.dsn = '';
    },
    appRunner: () => runApp(const MyApp()),
  );
}
