import 'package:flutter/material.dart';

class AppConstant {
  static const String BASE_URL =
      "https://chunlee-node-api-boilerplate.herokuapp.com";
  static const String APP_VERSION = "1.0.0";
  static const String LANGUAGE_PATH = "assets/languages";
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
