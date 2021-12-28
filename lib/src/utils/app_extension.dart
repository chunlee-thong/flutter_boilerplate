import 'dart:io';

extension MapExtension on Map {
  void addIfNotNull(dynamic key, dynamic data) {
    if (data != null) putIfAbsent(key, () => data);
  }

  dynamic getIfExist(dynamic key) {
    if (keys.contains(key)) {
      return this[key];
    }
    return null;
  }
}

extension FileExtensionMethod on FileSystemEntity {
  String get name => path.split("/").last;
  String get fileExtension => path.split(".").last;
}

extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? true);
}
