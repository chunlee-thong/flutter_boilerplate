import 'package:flutter/services.dart';

import '../constant/app_config.dart';

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
    // if(exception is FirebaseAuthException){
    //   errorMessage = exception.message;
    // }

    return errorMessage ?? exception.toString();
  }
}
