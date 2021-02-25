class FormValidator {
  static String validateField(String value, {String field}) {
    if (value.isEmpty) {
      return "Please input your $field";
    }
    return null;
  }

  static String isNumber(String value, {String field}) {
    if (value.isEmpty) {
      return "Please input your $field";
    }
    num asNumber = num.tryParse(value);
    if (asNumber is num) return null;
    return "$field must be a number";
  }
}
