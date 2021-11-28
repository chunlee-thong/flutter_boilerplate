import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/src/utils/logger.dart';

class ResponsiveSize {
  static BuildContext? _context;

  static Size? _size;

  static void init(BuildContext ctx) {
    _context = ctx;
    _size = MediaQuery.of(ctx).size;
    infoLog("Media query data: ${MediaQuery.of(ctx).toString()}");
  }

  static double responsiveSize(double phone, [double? tablet, double? laptop, double? smallPhone]) {
    double width = _size?.width ?? 480;
    infoLog(width);
    if (width >= 1024) {
      return laptop ?? phone;
    } else if (width >= 768) {
      return tablet ?? phone;
    } else if (width <= 350) {
      return smallPhone ?? phone;
    }
    return phone;
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget child;
  const ResponsiveBuilder({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveSize.init(context);
    return child;
  }
}
