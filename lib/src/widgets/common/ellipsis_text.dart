import 'package:flutter/material.dart';

class EllipsisText extends StatelessWidget {
  final String? text;
  final TextStyle style;
  final int maxLines;
  final TextAlign? textAlign;

  const EllipsisText(
    this.text, {
    Key? key,
    this.maxLines = 1,
    this.style = const TextStyle(),
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: style.copyWith(height: 1.2),
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      overflow: TextOverflow.ellipsis,
    );
  }
}
