import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dialog/message_dialog.dart';

class UIHelper {
  static Future<T?> showMessageDialog<T>(BuildContext context, dynamic message) async {
    return await showDialog(
      context: context,
      builder: (context) => CustomMessageDialog(
        message: message.toString(),
        title: "Information",
      ),
    );
  }

  static Future<T?> showErrorDialog<T>(BuildContext context, dynamic message) async {
    return await showDialog(
      context: context,
      builder: (context) => CustomMessageDialog.error(
        message: message.toString(),
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

  ///BuildContext isn't use, but required just in case something change
  static Future showToast(BuildContext context, dynamic message) async {
    await Fluttertoast.showToast(
      msg: "${message.toString()}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showSnackBar(BuildContext context, dynamic message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${message.toString()}"),
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
