import 'package:flutter/material.dart';

class SmallIconButton extends StatelessWidget {
  final Function onTap;
  final Widget icon;
  final EdgeInsets margin;
  final Color backgroundColor;
  final double borderRadius;
  final double elevation;

  const SmallIconButton({
    Key key,
    @required this.onTap,
    @required this.icon,
    this.margin = const EdgeInsets.all(8),
    this.borderRadius = 8,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius));
    return Card(
      shape: shape,
      color: backgroundColor,
      elevation: elevation,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon,
        ),
      ),
      margin: margin,
    );
  }
}
