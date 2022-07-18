import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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

  static String getReadableErrorMessage(Object exception) {
    String? errorMessage;
    if (exception is PlatformException) {
      errorMessage = exception.message;
    }

    if (exception is SocketException) {
      errorMessage = "No internet connection";
    }
    // if (exception is FirebaseAuthException) {
    //   errorMessage = exception.message;
    // }
    // if (exception is FirebaseException) {
    //   if (exception.code == "not-found") {
    //     errorMessage = "Action failed. Post might have been deleted.";
    //   } else {
    //     errorMessage = exception.message;
    //   }
    // }

    return errorMessage ?? exception.toString();
  }
}
