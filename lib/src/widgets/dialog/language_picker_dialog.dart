import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_locale.dart';
import '../../constant/app_style_decoration.dart';
import '../common/divider0.dart';

class LanguagePickerDialog extends StatelessWidget {
  const LanguagePickerDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: SuraDecoration.roundRect(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: SuraDecoration.radiusTop(4),
            ),
            alignment: Alignment.center,
            child: Text("Language", style: kSubHeaderStyle.applyColor(Colors.white)),
          ),
          const Divider0(),
          ...KAppLanguages.map((language) {
            return SuraListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(language.image),
              ),
              title: Text(language.name),
              separator: const Divider0(),
              onTap: () {
                context.setLocale(language.locale);
                Navigator.of(context).pop(language.locale);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
