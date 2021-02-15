import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import '../../constant/app_constant.dart';
import '../../constant/style_decoration.dart';

class LanguagePickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: JinWidget.roundRect(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text("Change Languages", style: kSubtitleStyle.medium),
            padding: const EdgeInsets.all(16),
          ),
          Divider(height: 0),
          ...APP_LOCALES.map((language) {
            return ListTile(
              leading: Icon(Icons.language),
              title: Text(language.name),
              onTap: () {
                context.locale = language.locale;
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
