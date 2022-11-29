import 'package:batlle_bots/styles/fonts.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  const AppText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: primaryTextStyle,
    );
  }
}
