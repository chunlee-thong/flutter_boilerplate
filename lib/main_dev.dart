import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app.dart';
import 'flavor.dart';
import 'my_app.dart';

Future main() async {
  setupFlavorConfiguration(Flavor.dev);
  await App.init();
  await SentryFlutter.init(
    (options) {
      options.dsn = '';
    },
    appRunner: () => runApp(const MyApp()),
  );
}
