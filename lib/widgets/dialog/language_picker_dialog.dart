import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_constant.dart';
import '../../constant/style_decoration.dart';
import '../common/divider0.dart';

class LanguagePickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: SuraStyle.roundRect(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: SuraStyle.radiusTop(4),
            ),
            alignment: Alignment.center,
            child: Text("Language",
                style: kSubHeaderStyle.applyColor(Colors.white)),
          ),
          Divider0(),
          ...APP_LOCALES.map((language) {
            return SuraListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(language.image),
              ),
              title: Text(language.name),
              separator: Divider0(),
              onTap: () {
                context.locale = language.locale;
                Navigator.of(context).pop(language.locale);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
