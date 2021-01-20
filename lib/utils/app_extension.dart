extension MapExtension on Map {
  void addIfNotNull(dynamic key, dynamic data) {
    if (data != null) this.putIfAbsent(key, () => data);
  }

  dynamic getIfExist(dynamic key) {
    if (this.keys.contains(key)) {
      return this[key];
    }
  }
}
