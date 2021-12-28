import 'package:flutter/foundation.dart';

void httpLog([dynamic log, dynamic additional = ""]) {
  if (kDebugMode) debugPrint("Http Log: $log $additional");
}

void infoLog([dynamic log, dynamic additional = ""]) {
  if (kDebugMode) debugPrint("Info Log: $log $additional");
}

void errorLog([dynamic log, dynamic additional = ""]) {
  debugPrint("Error Log: $log $additional");
}
