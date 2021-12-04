import 'package:flutter/material.dart';

class EllipsisText extends StatelessWidget {
  final dynamic content;
  final TextStyle style;
  final int maxLines;
  final TextAlign? textAlign;

  const EllipsisText(
    this.content, {
    Key? key,
    this.maxLines = 1,
    this.style = const TextStyle(),
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content == null ? "" : content.toString(),
      style: style.copyWith(height: 1.2),
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      overflow: TextOverflow.ellipsis,
    );
  }
}
