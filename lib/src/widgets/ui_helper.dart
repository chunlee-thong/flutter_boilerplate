import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart' as styled_toast;

import '../utils/app_utils.dart';
import 'dialog/message_dialog.dart';

class UIHelper {
  static Future<T?> showMessageDialog<T>(BuildContext context, String message) async {
    return await showDialog(
      context: context,
      builder: (context) => CustomMessageDialog(
        message: message,
        title: "Information",
      ),
    );
  }

  static Future<T?> showErrorDialog<T>(BuildContext context, Object error) async {
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

  static Future showToast(BuildContext context, String message) async {
    styled_toast.showToastWidget(
      Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        margin: const EdgeInsets.only(bottom: 64),
        child: Text(message, style: const TextStyle(color: Colors.white)),
      ),
      context: context,
      animDuration: Duration.zero,
      dismissOtherToast: true,
    );
  }

  static Future showTopSnackBar(BuildContext context, String message) async {
    styled_toast.showToastWidget(
      Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: const EdgeInsets.only(top: 64, left: 8, right: 8),
        width: double.infinity,
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      context: context,
      animDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 3),
      position: styled_toast.StyledToastPosition.top,
      animationBuilder: (context, controller, duration, child) {
        return FadeTransition(opacity: controller, child: child);
      },
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

  // ignore: non_constant_identifier_names
  static AppBar CustomAppBar({
    required String title,
    double elevation = 0.0,
    List<Widget>? actions,
    bool centerTitle = true,
    Color? backgroundColor,
  }) {
    return AppBar(
      title: Text(title),
      elevation: elevation,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
    );
  }
}
