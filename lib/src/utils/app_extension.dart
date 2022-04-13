import 'dart:io';

extension FileExtensionMethod on FileSystemEntity {
  String get name => path.split("/").last;
  String get fileExtension => path.split(".").last;
}

extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? true);
}
