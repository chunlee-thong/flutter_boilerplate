import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class AppDimension {
  static const EdgeInsets pageSpacing = EdgeInsets.all(16);

  ///Responsive value for 8
  static final double space8 = SkadiResponsive.value(8, 14, 20);

  ///Responsive value for 16
  static final double space16 = SkadiResponsive.value(16, 22, 28);
}
