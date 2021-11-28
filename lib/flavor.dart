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

      case Flavor.staging:
        return "Staging";

      case Flavor.production:
        return "Production";

      default:
        return "";
    }
  }
}

Future<void> setupFlavorConfiguration(Flavor flavor) async {
  AppConfig.BASE_URL = "https://express-boilerplate.chunleethong.com";
  F.flavor = flavor;
}
