import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';

import 'src/api/client/http_client.dart';
import 'src/constant/app_config.dart';
import 'src/constant/app_constant.dart';
import 'src/pages/splash/splash_page.dart';
import 'src/providers/auth_provider.dart';
import 'src/providers/loading_provider.dart';
import 'src/providers/theme_provider.dart';
import 'src/providers/user_provider.dart';
import 'src/services/local_storage_service/fss_storage_service.dart';
import 'src/services/local_storage_service/local_storage_service.dart';
import 'src/services/local_storage_service/spf_storage_service.dart';
import 'src/utils/hive_db_adapter.dart';
import 'src/utils/service_locator.dart';
import 'src/widgets/state_widgets/error_widget.dart';
import 'src/widgets/state_widgets/loading_widget.dart';
import 'src/widgets/state_widgets/page_loading.dart';

Future<void> registerAppConfiguration() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await EasyLocalization.ensureInitialized();
  bool isDesktop = Platform.isWindows || Platform.isMacOS;
  await LocalStorage.initialize(isDesktop ? SharedPreferencesStorageService() : FssStorageService());
  await ThemeProvider.initializeTheme();
  DefaultHttpClient.init();
  registerHiveAdapter();
  registerLocator();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Locale> languages = APP_LOCALES.map((lang) => lang.locale).toList();

  ///Change font family base on locale
  ThemeData customizeTheme(BuildContext context) {
    String fontName = context.locale == KH_LOCALE ? AppConfig.KH_FONT_NAME : AppConfig.EN_FONT_NAME;
    return Theme.of(context).copyWith(
      textTheme: Theme.of(context).textTheme.apply(fontFamily: fontName),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: false,
      builder: (context) => EasyLocalization(
        path: AppConfig.LANGUAGE_PATH,
        supportedLocales: languages,
        fallbackLocale: KH_LOCALE,
        startLocale: KH_LOCALE,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => LoadingProvider()),
          ],
          child: Builder(
            builder: (context) => Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return SuraProvider(
                  loadingWidget: const LoadingWidget(),
                  errorWidget: (error, onRefresh) {
                    return CustomErrorWidget(
                      message: error,
                      onRefresh: onRefresh,
                    );
                  },
                  child: MaterialApp(
                    title: AppConfig.APP_NAME,
                    navigatorKey: SuraNavigator.navigatorKey,
                    theme: themeProvider.getThemeData(),
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    builder: (context, child) {
                      ErrorWidget.builder = (detail) {
                        if (kReleaseMode) {
                          return const FlutterCustomErrorRendering();
                        }
                        return ErrorWidget(detail.exception);
                      };
                      return Theme(
                        child: PageLoading(child: child!),
                        data: customizeTheme(context),
                      );
                    },
                    home: const SplashScreenPage(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
