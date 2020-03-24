import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/widgets/dialog/general_message_dialog.dart';

class UIHelper {
  static Widget verticalSpace([double height = 8]) {
    return SizedBox(height: height);
  }

  static Widget horizontalSpace([double width = 8]) {
    return SizedBox(width: width);
  }

  static void showGeneralMessageDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => GeneralMessageDialog(
        content: message,
      ),
    );
  }
}
