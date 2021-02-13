import 'dart:io';

extension MapExtension on Map {
  void addIfNotNull(dynamic key, dynamic data) {
    if (data != null) this.putIfAbsent(key, () => data);
  }

  dynamic getIfExist(dynamic key) {
    if (this.keys.contains(key)) {
      return this[key];
    }
    return null;
  }
}

extension FileExtensionMethod on FileSystemEntity {
  String get name => this.path.split("/").last;
}
