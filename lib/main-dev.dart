import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './utils/hive_db_adapter.dart';
import './utils/service_locator.dart';
import 'app.dart';
import 'constant/app_config.dart';
import 'flavor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  registerHiveAdapter();
  registerLocator();
  setupEnvConfig();
  return runApp(MyApp());
}

void setupEnvConfig() {
  AppConfig.BASE_URL = "https://express-boilerplate.chunleethong.com";
  F.flavor = Flavor.dev;
}
