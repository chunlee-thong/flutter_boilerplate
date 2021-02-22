import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:toast/toast.dart';

class UIHelper {
  static Future<T> showMessageDialog<T>(
      BuildContext context, dynamic message) async {
    return await showDialog(
      context: context,
      builder: (context) => JinSimpleDialog(content: message.toString()),
    );
  }

  static Future<T> showErrorDialog<T>(
      BuildContext context, dynamic message) async {
    return await showDialog(
      context: context,
      builder: (context) => JinSimpleDialog(content: message.toString()),
    );
  }

  static void showToast(BuildContext context, dynamic message) {
    Toast.show(message.toString(), context);
  }

  static void showSnackBar(
      GlobalKey<ScaffoldState> scaffoldKey, dynamic message) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message.toString()),
        margin: const EdgeInsets.all(8),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  static Widget CustomAppBar({
    @required String title,
    double elevation = 2.0,
    List<Widget> action,
    bool centerTitle = false,
    Color backgroundColor,
  }) {
    return AppBar(
      title: Text(title),
      elevation: elevation,
      actions: action,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
    );
  }
}
