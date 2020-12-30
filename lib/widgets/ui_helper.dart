import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:toast/toast.dart';

class UIHelper {
  static Future<T> showGeneralMessageDialog<T>(
    BuildContext context,
    String message,
  ) {
    return showDialog(
      context: context,
      builder: (context) => JinSimpleDialog(
        content: message,
      ),
    );
  }

  static void showToast(BuildContext context, String message) {
    Toast.show(message, context);
  }
}
