enum Flavor {
  dev,
  staging,
  production,
}

class F {
  static Flavor flavor;

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
