import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/constant/style.dart';

class GeneralMessageDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;

  GeneralMessageDialog({
    this.confirmText = "OK",
    @required this.content,
    this.title = "Information",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: roundRect(16),
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          child: Text(confirmText),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
