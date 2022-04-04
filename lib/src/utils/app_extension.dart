import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension FileExtensionMethod on FileSystemEntity {
  String get name => path.split("/").last;
  String get fileExtension => path.split(".").last;
}

extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? true);
}

extension LocateProvider on ChangeNotifier {
  static T getProvider<T>(BuildContext context, [bool listen = false]) {
    return Provider.of<T>(context, listen: listen);
  }
}
