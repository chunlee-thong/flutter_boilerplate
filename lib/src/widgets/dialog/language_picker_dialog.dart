import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

import '../../core/constant/app_locale.dart';
import '../../core/style/textstyle.dart';

class LanguagePickerDialog extends StatelessWidget {
  const LanguagePickerDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(SkadiResponsive.value(40, 140, 240)),
      shape: SkadiDecoration.roundRect(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: SkadiDecoration.radiusTop(8),
            ),
            alignment: Alignment.center,
            child: Text("Language", style: kSubHeaderStyle.white),
          ),
          for (var language in kAppLanguages)
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(language.image),
              ),
              title: Text(language.name),
              onTap: () {
                context.setLocale(language.locale);
                Navigator.of(context).pop(language.locale);
              },
            )
        ],
      ),
    );
  }
}
