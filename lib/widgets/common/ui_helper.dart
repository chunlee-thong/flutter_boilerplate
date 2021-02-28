import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:toast/toast.dart';

class UIHelper {
  static Future<T> showMessageDialog<T>(BuildContext context, dynamic message) async {
    return await showDialog(
      context: context,
      builder: (context) => SuraSimpleDialog(content: message.toString()),
    );
  }

  static Future<T> showErrorDialog<T>(BuildContext context, dynamic message) async {
    return await showDialog(
      context: context,
      builder: (context) => SuraSimpleDialog(
        content: message.toString(),
        title: "Error",
      ),
    );
  }

  static void showToast(BuildContext context, dynamic message) {
    Toast.show(message.toString(), context, duration: 3);
  }

  static void showSnackBar(BuildContext context, dynamic message, [GlobalKey<ScaffoldState> scaffoldKey]) {
    if (scaffoldKey != null) {
      scaffoldKey.currentState.hideCurrentSnackBar();
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(message.toString()),
          margin: const EdgeInsets.all(8),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message.toString()),
          margin: const EdgeInsets.all(8),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  static Widget CustomAppBar({
    @required String title,
    double elevation = 2.0,
    List<Widget> actions,
    bool centerTitle = false,
    Color backgroundColor,
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
