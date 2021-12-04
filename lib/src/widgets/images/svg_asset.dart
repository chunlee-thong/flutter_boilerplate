import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgAsset extends StatelessWidget {
  final String icon;
  final double size;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? iconColor;
  final Color? bgColor;
  const SvgAsset({
    Key? key,
    required this.icon,
    this.size = 18,
    this.padding,
    this.margin,
    this.iconColor,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      width: size,
      height: size,
      color: iconColor,
    );
  }
}
