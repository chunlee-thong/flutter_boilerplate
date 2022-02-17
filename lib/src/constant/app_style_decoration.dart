import 'package:flutter/material.dart';

import 'app_theme_color.dart';

const TextStyle kHeaderStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);
const TextStyle kSubHeaderStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
);
const TextStyle kTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
const TextStyle kNormalStyle = TextStyle(
  fontSize: 14,
);
const TextStyle kCaptionStyle = TextStyle(
  fontSize: 12,
);
const TextStyle kOverLineStyle = TextStyle(
  fontSize: 10,
);

extension StyleExtension on TextStyle {
  TextStyle get primary => copyWith(color: AppColor.primary);
  TextStyle get accent => copyWith(color: AppColor.accent);
}

///
final BoxShadow kGreyShadow2 = BoxShadow(
  color: Colors.grey.withOpacity(0.2),
  blurRadius: 2,
  spreadRadius: 1.0,
  offset: const Offset(0.0, 4.0),
);

final BoxShadow kGreyShadow4 = BoxShadow(
  color: Colors.grey.withOpacity(0.2),
  blurRadius: 4,
  spreadRadius: 4,
  offset: const Offset(0.0, 4.0),
);
