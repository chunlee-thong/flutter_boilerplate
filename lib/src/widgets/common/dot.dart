import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final double size;
  final Color color;
  final double space;

  const Dot({
    Key? key,
    this.size = 8,
    this.color = Colors.grey,
    this.space = 8,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: size,
      height: size,
      margin: EdgeInsets.only(right: space),
    );
  }
}
