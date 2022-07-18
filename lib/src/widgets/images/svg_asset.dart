import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../core/style/color.dart';

class SvgAsset extends StatelessWidget {
  final String icon;
  final double size;
  final Color? bgColor;
  final EdgeInsets padding;
  final Color? iconColor;
  final EdgeInsets? margin;
  final ShapeBorder? shape;
  final BorderSide? side;
  final VoidCallback? onTap;
  final bool _iconOnly;
  final double? width;
  final double? height;
  final Widget? errorPlaceholder;

  ///A Widget to handle a svg in our asset folder
  const SvgAsset({
    Key? key,
    required this.icon,
    this.size = 24,
    this.iconColor = AppColor.primary,
    this.bgColor = Colors.transparent,
    this.padding = const EdgeInsets.all(16.0),
    this.shape,
    this.side,
    this.margin,
    this.onTap,
    this.width,
    this.height,
    this.errorPlaceholder,
  })  : _iconOnly = false,
        super(key: key);

  const SvgAsset.iconOnly({
    Key? key,
    required this.icon,
    this.size = 18,
    this.iconColor = AppColor.primary,
    this.bgColor = Colors.transparent,
    this.padding = const EdgeInsets.all(0),
    this.shape,
    this.side,
    this.margin,
    this.onTap,
    this.width,
    this.height,
    this.errorPlaceholder,
  })  : _iconOnly = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final customShape = shape ?? SuraDecoration.roundRect();
    final iconChild = SvgPicture.asset(
      icon,
      width: size,
      height: size,
      color: iconColor,
      placeholderBuilder: errorPlaceholder != null
          ? (context) {
              return errorPlaceholder!;
            }
          : null,
    );
    // color: iconColor,
    // width: size,
    // height: size,

    if (_iconOnly) {
      return iconChild;
    }
    final child = Card(
      shape: customShape,
      color: bgColor,
      elevation: 0.0,
      margin: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        customBorder: customShape,
        child: Padding(
          padding: padding,
          child: iconChild,
        ),
      ),
    );
    if (width != null && height != null) {
      return SizedBox(width: width, height: height, child: child);
    }
    return child;
  }
}
