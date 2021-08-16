import 'package:flutter/material.dart';

import 'app_theme_color.dart';

//custom textStyle
const TextStyle kHeaderStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);
const TextStyle kSubHeaderStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
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

//extension

extension StyleExtension on TextStyle {
  TextStyle get black => apply(color: Colors.black);
  TextStyle get white => apply(color: Colors.white);
  TextStyle get red => apply(color: Colors.red);
  TextStyle get grey => apply(color: Colors.grey);
  TextStyle get green => apply(color: Colors.green);
  TextStyle get primary => apply(color: AppColor.primary);
  TextStyle get accent => apply(color: AppColor.accent);
  TextStyle get underline => apply(decoration: TextDecoration.underline);
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

///material textStyle
class MTS {
  static const TextStyle h1 = TextStyle(
    fontSize: 96,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.5,
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 48,
    letterSpacing: 0.0,
  );
  static const TextStyle h4 = TextStyle(
    fontSize: 34,
    letterSpacing: 0.25,
  );
  static const TextStyle h5 = TextStyle(
    fontSize: 24,
    letterSpacing: 0.0,
  );
  static const TextStyle h6 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );
  static const TextStyle subtitle1 = TextStyle(
    fontSize: 16,
    letterSpacing: 0.15,
  );
  static const TextStyle subtitle2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    letterSpacing: 0.5,
  );
  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    letterSpacing: 0.25,
  );
  static const TextStyle buttonStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  );
  static const TextStyle captionStyle = TextStyle(
    fontSize: 12,
    letterSpacing: 0.4,
  );
}
