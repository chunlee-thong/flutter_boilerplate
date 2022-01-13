import 'package:flutter/material.dart';

class ResponsiveSize {
  static Size? _size;

  static void init(BuildContext ctx) {
    _size = MediaQuery.of(ctx).size;
  }

  static double responsiveSize(double phone, [double? laptop, double? tablet, double? smallPhone]) {
    double width = _size?.width ?? 480;
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
