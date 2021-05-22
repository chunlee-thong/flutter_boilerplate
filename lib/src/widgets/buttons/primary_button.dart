import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_theme_color.dart';

class PrimaryButton extends StatelessWidget {
  final FutureOr<void> Function() onPressed;
  final Widget child;
  final bool fullWidth;
  final Color color;
  final OutlinedBorder? shape;
  final EdgeInsets margin;
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.fullWidth = true,
    this.color = AppColor.primary,
    this.shape,
    this.margin = const EdgeInsets.symmetric(vertical: 16),
  }) : super(key: key);

  const PrimaryButton.accent({
    Key? key,
    required this.onPressed,
    required this.child,
    this.fullWidth = true,
    this.color = AppColor.accent,
    this.shape,
    this.margin = const EdgeInsets.symmetric(vertical: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuraAsyncButton(
      onPressed: onPressed,
      child: child,
      fullWidth: fullWidth,
      color: color,
      margin: margin,
      shape: shape,
    );
  }
}
