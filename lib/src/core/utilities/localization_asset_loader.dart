//
//
//
//
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:skadi/skadi.dart';

class HttpAssetLoader extends AssetLoader {
  const HttpAssetLoader();

  static Map<Locale, Map<String, dynamic>> cached = {};

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    if (cached[locale] != null) {
      debugLog("Read Localization from cache");
      return cached[locale]!;
    }
    try {
      const kmUrl = "https://api.jsonbin.io/v3/b/6499514ab89b1e2299b537cd";
      const enUrl = "https://api.jsonbin.io/v3/b/64994f6ab89b1e2299b536fb";
      final response = await Dio().get(locale.languageCode == "km" ? kmUrl : enUrl);
      final data = response.data['record'];
      debugLog("Download Localization from ${response.requestOptions.uri}");
      cached[locale] ??= data;
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
