import 'package:flutter/material.dart';

import 'dialog/general_message_dialog.dart';

class UIHelper {
  static Future<T> showGeneralMessageDialog<T>(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (context) => GeneralMessageDialog(
        content: message,
      ),
    );
  }
}
