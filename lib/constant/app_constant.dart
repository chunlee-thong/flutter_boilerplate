import 'package:flutter/material.dart';

class AppConstant {
  static const String LANGUAGE_PATH = "assets/languages";
  // ignore: non_constant_identifier_names
  static String TOKEN = "";
}

const EN_LOCALE = Locale('en', 'US');
const KH_LOCALE = Locale('km', 'KH');

class ErrorMessage {
  static const UNEXPECTED_ERROR = "An unexpected error occur!";
  static const CONNECTION_ERROR =
      "Error connecting to server. Please check your internet connection or Try again later!";
  static const TIMEOUT_ERROR =
      "Connection timeout. Please check your internet connection or Try again later!";
}
