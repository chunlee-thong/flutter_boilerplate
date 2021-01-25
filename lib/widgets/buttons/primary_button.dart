import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class PrimaryButton extends StatelessWidget {
  final Future<void> Function() onPressed;
  final Widget child;
  final bool fullWidth;

  const PrimaryButton({
    Key key,
    this.onPressed,
    this.child,
    this.fullWidth = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return JinLoadingButton(
      onPressed: onPressed,
      child: child,
      fullWidth: fullWidth,
    );
  }
}
