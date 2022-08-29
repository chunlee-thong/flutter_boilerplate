import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class AppColor {
  //main
  static const Color primary = Color(0xFFE94C89);
  static const Color accent = Color(0xFF2F3193);
  //other
  static const Color fbColor = Color(0xFF3b5998);
  static const Color googleRed = Color(0xFFDB4437);
  static const Color appleColor = Color(0xFF555555);
  static const Color twitterColor = Color(0xFF1DA1F2);
  //material
  static final MaterialColor materialPrimary = SkadiColor.toMaterial(primary);
  static final MaterialColor materialAccent = SkadiColor.toMaterial(accent);
}
