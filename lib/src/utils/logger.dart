import 'package:flutter/foundation.dart';

void httpLog([dynamic log, dynamic additional = ""]) {
  if (kDebugMode) print("Http Log: $log $additional");
}

void infoLog([dynamic log, dynamic additional = ""]) {
  if (kDebugMode) print("Info Log: $log $additional");
}

void errorLog([dynamic log, dynamic additional = ""]) {
  print("Error Log: $log $additional");
}
