import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../constant/app_config.dart';

///Ensure that widget is react to locale change
void ensuredLocalize(BuildContext context) {
  context.locale;
}

class AppUtils {
  ///Get real file url if some API doesn't response a full url
  static String? getFileUrl(String? file) {
    if (file == null) return null;
    if (file.startsWith("http")) {
      return file;
    }
    String image = "${AppConfig.baseApiUrl}/uploads/$file";
    return image;
  }
}
