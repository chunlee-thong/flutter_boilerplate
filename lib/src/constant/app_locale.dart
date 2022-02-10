import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/constant/app_assets.dart';

import '../models/others/language_model.dart';

//
const Locale EN_LOCALE = Locale('en', 'US');
const Locale KH_LOCALE = Locale('km', 'KH');
//

const List<LanguageModel> KAppLanguages = [
  LanguageModel(
    locale: EN_LOCALE,
    name: "English",
    image: AppAssets.usFlag,
  ),
  LanguageModel(
    locale: KH_LOCALE,
    name: "ខ្មែរ",
    image: AppAssets.cambodiaFlag,
  ),
];
