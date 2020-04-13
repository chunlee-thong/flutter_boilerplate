import 'package:flutter/material.dart';

import 'dialog/general_message_dialog.dart';

class UIHelper {
  static Widget verticalSpace([double height = 8]) {
    return SizedBox(height: height);
  }

  static Widget horizontalSpace([double width = 8]) {
    return SizedBox(width: width);
  }

  static Future<T> showGeneralMessageDialog<T>(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (context) => GeneralMessageDialog(
        content: message,
      ),
    );
  }
}
