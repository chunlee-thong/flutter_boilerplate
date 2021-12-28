import 'package:easy_localization/easy_localization.dart';
import '../utils/app_extension.dart';

import '../constant/locale_keys.dart';

class FormValidator {
  static const Pattern emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static final RegExp regex = RegExp(emailPattern as String);

  static String? validateEmail(String? value) {
    if (value.isNullOrEmpty) {
      return tr(LocaleKeys.please_input_a, args: ["email"]);
    }
    if (!regex.hasMatch(value!)) {
      return tr("Invalid email address");
    }
  }

  static String? validateField(String? value, {required String field, int? length}) {
    if (value.isNullOrEmpty) {
      return tr(LocaleKeys.please_input_a, args: [field]);
    }
    if (length != null && value!.length < length) {
      return tr(LocaleKeys.field_char_long, args: [field, "$length"]);
    }
    return null;
  }

  static String? validateYourField(String? value, {required String field, int? length}) {
    if (value.isNullOrEmpty) {
      return tr(LocaleKeys.please_input_your, args: [field]);
    }
    if (length != null && value!.length < length) {
      return tr(LocaleKeys.field_char_long, args: [field, "$length"]);
    }
    return null;
  }

  static String? validateValue(Object? value, {required String field}) {
    if (value == null) {
      return tr(LocaleKeys.please_input_a, args: [field]);
    }
    return null;
  }

  static String? isNumber(String? value, {required String field}) {
    if (value.isNullOrEmpty) {
      return tr(LocaleKeys.please_input_a, args: [field]);
    }
    //delete formatting string
    value = value!.replaceAll(",", "");
    num? asNumber = num.tryParse(value);
    if (asNumber is num) return null;
    return tr(LocaleKeys.field__must_be_number, args: [field]);
  }

  static String? validateConfirmPassword(String? value, String newPassword) {
    if (value.isNullOrEmpty) {
      return tr(LocaleKeys.please_input_a, args: [LocaleKeys.confirm_password.tr()]);
    }

    if (value!.trim() != newPassword.trim()) {
      return LocaleKeys.confirm_password_incorrect.tr();
    }
    return null;
  }
}
