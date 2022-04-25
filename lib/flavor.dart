enum Flavor {
  dev,
  staging,
  production,
}

class F {
  static late Flavor flavor;
}

///Must be call at main function
Future<void> setupFlavorConfiguration(Flavor flavor) async {
  F.flavor = flavor;
}
