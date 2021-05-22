import 'src/constant/app_config.dart';

enum Flavor {
  dev,
  staging,
  production,
}

class F {
  static Flavor? flavor;

  static String get title {
    switch (flavor) {
      case Flavor.dev:
        return "Dev";
        break;
      case Flavor.staging:
        return "Staging";
        break;
      case Flavor.production:
        return "Production";
        break;
    }
    return "";
  }
}

void setupDevEnvConfig() {
  AppConfig.BASE_URL = "https://express-boilerplate.chunleethong.com";
  F.flavor = Flavor.dev;
}

void setupStagingEnvConfig() {
  AppConfig.BASE_URL = "https://express-boilerplate.chunleethong.com";
  F.flavor = Flavor.staging;
}

void setupProdEnvConfig() {
  AppConfig.BASE_URL = "https://express-boilerplate.chunleethong.com";
  F.flavor = Flavor.production;
}
