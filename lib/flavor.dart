import 'src/constant/app_config.dart';

enum Flavor {
  dev,
  staging,
  production,
}

class F {
  static late Flavor flavor;
  static String get title => flavor == Flavor.production ? "prod" : flavor.name;
}

///Must be call at main function
Future<void> setupFlavorConfiguration(Flavor flavor) async {
  F.flavor = flavor;
  AppConfig.baseApiUrl = "https://express-boilerplate-${F.title}.lynical.com";
}
