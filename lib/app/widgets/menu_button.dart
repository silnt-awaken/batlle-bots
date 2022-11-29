import 'package:batlle_bots/app/widgets/app_text.dart';
import 'package:batlle_bots/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuButton extends StatelessWidget {
  final String text;
  const MenuButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/$text'),
      child: Container(
        margin: const EdgeInsets.all(16.0),
        height: 125,
        width: 250,
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(
            color: accentColor,
            width: 10,
          ),
        ),
        alignment: Alignment.center,
        child: AppText(text),
      ),
    );
  }
}
