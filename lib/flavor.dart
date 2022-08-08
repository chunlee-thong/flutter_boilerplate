enum Flavor {
  dev,
  staging,
  production,
}

class F {
  static late Flavor flavor;
}

Future<void> setupFlavorConfiguration(Flavor flavor) async {
  F.flavor = flavor;
}
