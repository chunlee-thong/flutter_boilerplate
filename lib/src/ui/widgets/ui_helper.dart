import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:toast/toast.dart';

import 'dialog/custom_error_dialog.dart';

class UIHelper {
  static Future<T?> showMessageDialog<T>(BuildContext context, dynamic message) async {
    return await showDialog(
      context: context,
      builder: (context) => SuraSimpleDialog(content: message.toString()),
    );
  }

  static Future<T?> showErrorDialog<T>(BuildContext context, dynamic message) async {
    return await showDialog(
      context: context,
      builder: (context) => CustomErrorDialog(
        message: message.toString(),
        title: "Oh Snap",
      ),
    );
  }

  static void showToast(BuildContext context, dynamic message) {
    Toast.show(message.toString(), context, duration: 3);
  }

  static void showSnackBar(BuildContext context, dynamic message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message.toString()),
        margin: const EdgeInsets.all(8),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static AppBar CustomAppBar({
    required String title,
    double elevation = 2.0,
    List<Widget>? actions,
    bool centerTitle = false,
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
