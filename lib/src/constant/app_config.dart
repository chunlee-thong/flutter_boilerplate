import 'package:flutter_boilerplate/flavor.dart';

class AppConfig {
  //
  static const String appName = "Flutter Boilerplate";
  static const String appVersion = "0.0.1";
  //
  static const String enFontName = "GoogleSans";
  static const String khFontName = "NotoSansKhmer";
  //
  static const String languageAssetPath = "assets/languages";
  //
  //static String baseApiUrl = "https://express-boilerplate-dev.lynical.com";

  static const Map<Flavor, String> baseApiUrl = {
    Flavor.dev: "https://express-boilerplate-dev.lynical.com",
    Flavor.staging: "https://express-boilerplate-staging.lynical.com",
    Flavor.production: "https://express-boilerplate-prod.lynical.com",
  };

  static String sentryDsn = "";
}
