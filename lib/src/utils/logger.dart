import 'package:flutter/foundation.dart';

void httpLog([dynamic log, dynamic additional = ""]) {
  // ignore: avoid_print
  if (kDebugMode) print("Http Log: $log $additional");
}

void infoLog([dynamic log, dynamic additional = ""]) {
  // ignore: avoid_print
  if (kDebugMode) print("Info Log: $log $additional");
}

void errorLog([dynamic log, dynamic additional = ""]) {
  // ignore: avoid_print
  print("Error Log: $log $additional");
}
