import 'package:flutter/material.dart';

class XText extends StatelessWidget {
  final double? fontSize;
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  const XText(this.text, {Key? key, this.fontSize, this.color, this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: fontSize, color: color, fontWeight: fontWeight));
  }
}
