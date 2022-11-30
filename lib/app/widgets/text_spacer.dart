import 'package:batlle_bots/app/app_barrel.dart';
import 'package:flutter/material.dart';

class TextSpacer extends StatelessWidget {
  final String leading;
  final String trailing;
  const TextSpacer({super.key, required this.leading, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [AppText(leading), AppText(trailing)],
      ),
    );
  }
}
