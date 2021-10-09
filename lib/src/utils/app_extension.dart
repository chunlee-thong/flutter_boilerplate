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
}

extension StringUtil on String {
  String obscure([bool? condition]) => condition == true ? replaceAll(RegExp(r'.'), "*") : this;
  String obscureLast([int length = 4]) => replaceAll(RegExp(".{$length}\$"), '*' * length);

  bool isEmail() {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return regex.hasMatch(this);
  }
}
