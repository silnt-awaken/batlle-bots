import 'package:batlle_bots/styles/fonts.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  const AppText(this.text,
      {this.color, this.fontSize, this.textAlign, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: primaryTextStyle.copyWith(
        color: color,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
    );
  }
}
