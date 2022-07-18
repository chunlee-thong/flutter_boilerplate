import 'package:flutter/material.dart';

import '../../models/others/language_model.dart';
import 'app_assets.dart';

//
const Locale enLocale = Locale('en', 'US');
const Locale khLocale = Locale('km', 'KH');
//

const List<LanguageModel> kAppLanguages = [
  LanguageModel(
    locale: enLocale,
    name: "English",
    image: AppAssets.usFlag,
  ),
  LanguageModel(
    locale: khLocale,
    name: "ខ្មែរ",
    image: AppAssets.cambodiaFlag,
  ),
];
