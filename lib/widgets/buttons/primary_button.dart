import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

import '../../constant/app_theme_color.dart';

class PrimaryButton extends StatelessWidget {
  final FutureOr<void> Function() onPressed;
  final Widget child;
  final bool fullWidth;
  final Color color;
  const PrimaryButton({
    Key key,
    this.onPressed,
    this.child,
    this.fullWidth = true,
    this.color = AppColor.primary,
  }) : super(key: key);

  const PrimaryButton.accent({
    Key key,
    this.onPressed,
    this.child,
    this.fullWidth = true,
    this.color = AppColor.accent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JinLoadingButton(
      onPressed: onPressed,
      child: child,
      fullWidth: fullWidth,
      color: color,
    );
  }
}
