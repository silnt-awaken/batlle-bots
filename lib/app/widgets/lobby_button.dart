import 'package:batlle_bots/app/app_barrel.dart';
import 'package:flutter/material.dart';

class LobbyButton extends StatelessWidget {
  final String text;
  final Color color;
  const LobbyButton({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(32),
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: AppText(
        text,
        fontSize: 14,
        textAlign: TextAlign.center,
      ),
    );
  }
}
