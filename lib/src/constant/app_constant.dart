import 'package:flutter/material.dart';

import '../models/others/language_model.dart';

class AppConstant {}

const Locale EN_LOCALE = Locale('en', 'US');
const Locale KH_LOCALE = Locale('km', 'KH');

class ErrorMessage {
  static const UNEXPECTED_ERROR = "An unexpected error occur!";
  static const UNEXPECTED_TYPE_ERROR = "An unexpected type error occur!";
  static const CONNECTION_ERROR = "Error connecting to server. Please check your internet connection or Try again later!";
  static const TIMEOUT_ERROR = "Connection timeout. Please check your internet connection or Try again later!";
}

const List<LanguageModel> APP_LOCALES = [
  const LanguageModel(
    locale: EN_LOCALE,
    name: "English",
    image: "https://ecolebranchee.com/wp-content/uploads/2015/04/etats-unis-drapeau.gif",
  ),
  const LanguageModel(
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
