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
        return "dev";

      case Flavor.staging:
        return "staging";

      case Flavor.production:
        return "prod";

      default:
        return "";
    }
  }
}

Future<void> setupFlavorConfiguration(Flavor flavor) async {
  F.flavor = flavor;
  AppConfig.BASE_URL = "https://express-boilerplate-${F.title}.lynical.com";
}
