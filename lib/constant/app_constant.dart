import 'package:flutter/material.dart';

import '../models/others/language_model.dart';

class AppConstant {
  // ignore: non_constant_identifier_names
  static String TOKEN;
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
