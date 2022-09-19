import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../core/utilities/app_utils.dart';
import 'dialog/message_dialog.dart';

abstract class UIHelper {
  static Future<T?> showMessageDialog<T>(BuildContext context, String message) async {
    return await showDialog(
      context: context,
      builder: (context) => CustomMessageDialog(
        message: message,
        title: "Information",
      ),
    );
  }

  static Future<T?> showErrorDialog<T>(BuildContext context, error) async {
    String errorMessage = AppUtils.getReadableErrorMessage(error);
    return await showDialog(
      context: context,
      builder: (context) => CustomMessageDialog.error(
        message: errorMessage,
        title: "Error",
      ),
    );
  }

  static Future<T?> showCustomDialog<T>(BuildContext context, Widget dialog) async {
    return await showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }

  ///Show a simple toast at bottom position
  static Future showToast(BuildContext context, String message) async {
    showToastWidget(
      Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        margin: const EdgeInsets.only(bottom: 64),
        child: Text(message, style: const TextStyle(color: Colors.white)),
      ),
      position: ToastPosition.bottom,
      dismissOtherToast: true,
    );
  }

  ///Show an error toast at Top position
  static Future showErrorToast(
    BuildContext context,
    String message, {
    ToastPosition position = ToastPosition.top,
  }) async {
    showToastWidget(
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        width: double.infinity,
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      context: context,
      duration: const Duration(seconds: 3),
      position: position,
      dismissOtherToast: true,
    );
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        margin: const EdgeInsets.all(8),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ),
    );
  }
}
