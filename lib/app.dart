import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/http/client/http_client.dart';
import 'src/providers/theme_provider.dart';
import 'src/services/local_storage_service/fss_storage_service.dart';
import 'src/services/local_storage_service/local_storage_service.dart';
import 'src/utils/service_locator.dart';

class App {
  App._();

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await EasyLocalization.ensureInitialized();
    await LocalStorage.initialize(FssStorageService());
    await ThemeProvider.initializeTheme();
    DefaultHttpClient.init();
    registerLocator();
  }
}
