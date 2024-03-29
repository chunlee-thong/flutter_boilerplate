import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class PrimaryButton extends StatelessWidget {
  final FutureOr<void> Function() onPressed;
  final Widget child;
  final bool fullWidth;
  final Color? color;
  final OutlinedBorder? shape;
  final EdgeInsets margin;
  final Widget? startIcon;

  ///Primary button used in our app
  ///Usually this is not necessary
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.fullWidth = true,
    this.color,
    this.shape,
    this.margin = const EdgeInsets.symmetric(vertical: 16),
    this.startIcon,
  }) : super(key: key);

  const PrimaryButton.accent({
    Key? key,
    required this.onPressed,
    required this.child,
    this.fullWidth = true,
    this.color,
    this.shape,
    this.startIcon,
    this.margin = const EdgeInsets.symmetric(vertical: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkadiAsyncButton(
      startIcon: startIcon,
      onPressed: onPressed,
      fullWidth: fullWidth,
      backgroundColor: color,
      foregroundColor: Colors.white,
      margin: margin,
      shape: shape,
      child: child,
    );
  }
}
