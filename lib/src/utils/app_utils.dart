import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../constant/app_config.dart';

class AppUtils {
  static void util() {}

  static String getFileUrl(String? file) {
    if (file == null) return "";
    if (file.startsWith("http")) {
      return file;
    }
    String image = "${AppConfig.BASE_URL}/uploads/$file";
    return image;
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({this.milliseconds = 800});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
