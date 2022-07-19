import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/services/local_storage_service/spf_storage_service.dart';

import 'flavor.dart';
import 'src/controllers/theme_controller.dart';
import 'src/repository/index.dart';
import 'src/services/local_storage_service/fss_storage_service.dart';
import 'src/services/local_storage_service/local_storage_service.dart';

class App {
  App._();

  static Future bootstrap(Flavor flavor) async {
    setupFlavorConfiguration(flavor);
    WidgetsFlutterBinding.ensureInitialized();
    await clearSecureStorageOnFirstRun();
    await EasyLocalization.ensureInitialized();
    await LocalStorage.initialize(Platform.isMacOS ? SharedPreferencesStorageService() : FssStorageService());
    await ThemeController.initializeTheme();
    registerRepositories();
  }
}
