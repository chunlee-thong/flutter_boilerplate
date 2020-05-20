import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class WidgetHelper {
  static Future<T> showGeneralMessageDialog<T>(
      BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (context) => JinSimpleDialog(
        content: message,
      ),
    );
  }
}
