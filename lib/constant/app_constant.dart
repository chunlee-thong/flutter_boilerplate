import 'package:flutter/material.dart';

import '../models/others/language_model.dart';

class AppConstant {
  static String TOKEN;

  static void clear() {
    TOKEN = null;
  }
}

const Locale EN_LOCALE = Locale('en', 'US');
const Locale KH_LOCALE = Locale('km', 'KH');

class ErrorMessage {
  static const UNEXPECTED_ERROR = "An unexpected error occur!";
  static const CONNECTION_ERROR =
      "Error connecting to server. Please check your internet connection or Try again later!";
  static const TIMEOUT_ERROR =
      "Connection timeout. Please check your internet connection or Try again later!";
}

const List<LanguageModel> APP_LOCALES = [
  const LanguageModel(EN_LOCALE, "English"),
  const LanguageModel(KH_LOCALE, "ខ្មែរ"),
];

class HttpMethod {
  HttpMethod._();
  static const String GET = "get";
  static const String POST = "post";
  static const String PATCH = "patch";
  static const String PUT = "put";
  static const String DELETE = "delete";
}
