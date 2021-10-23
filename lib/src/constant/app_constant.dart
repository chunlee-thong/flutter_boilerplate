import 'package:flutter/material.dart';

import '../models/others/language_model.dart';

class AppConstant {}

class ErrorMessage {
  static const String UNEXPECTED_ERROR = "An unexpected error occur!";
  static const String INTERNAL_SERVER_ERROR = "Internal server error, Please try again later.";
  static const String UNEXPECTED_TYPE_ERROR = "An unexpected type error occur!";
  static const String CONNECTION_ERROR =
      "Error connecting to server. Please check your internet connection or Try again later!";
  static const String TIMEOUT_ERROR = "Connection timeout. Please check your internet connection or Try again later!";
}

const Locale EN_LOCALE = Locale('en', 'US');
const Locale KH_LOCALE = Locale('km', 'KH');

const List<LanguageModel> APP_LOCALES = [
  LanguageModel(
    locale: EN_LOCALE,
    name: "English",
    image: "https://ecolebranchee.com/wp-content/uploads/2015/04/etats-unis-drapeau.gif",
  ),
  LanguageModel(
    locale: KH_LOCALE,
    name: "ខ្មែរ",
    image: "https://wonderfulengineering.com/wp-content/uploads/2015/08/Cambodia-flag-3.gif",
  ),
];

class HttpMethod {
  HttpMethod._();

  static const String GET = "get";
  static const String POST = "post";
  static const String PATCH = "patch";
  static const String PUT = "put";
  static const String DELETE = "delete";
}
