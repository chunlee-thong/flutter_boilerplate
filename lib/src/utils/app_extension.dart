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

extension StringUtil on String {
  String obsecure([bool? condition]) => condition == true ? this.replaceAll(RegExp(r'.'), "*") : this;
  String obsecureLast([int length = 4]) => this.replaceAll(RegExp(".{$length}\$"), '*' * length);

  bool isEmail() {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern as String);
    return regex.hasMatch(this);
  }
}
