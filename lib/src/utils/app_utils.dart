import '../constant/app_config.dart';

class AppUtils {
  ///Get real file url if some API doesn't response a full url
  static String getFileUrl(String? file) {
    if (file == null) return "";
    if (file.startsWith("http")) {
      return file;
    }
    String image = "${AppConfig.baseApiUrl}/uploads/$file";
    return image;
  }
}
