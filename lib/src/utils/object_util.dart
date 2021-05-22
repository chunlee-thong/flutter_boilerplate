class ObjectUtils {
  static String getLastIndexString(String? data, [int length = 2]) {
    if (data == null || data == "null") return "null";
    return data.substring(data.length - length);
  }
}
