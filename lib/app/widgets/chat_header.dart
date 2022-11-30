import 'package:batlle_bots/app/app_barrel.dart';
import 'package:batlle_bots/repositories/game_repository.dart';
import 'package:batlle_bots/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 16.0),
      color: buttonColor,
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              context.pop();
              await GameRepository().close();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: AppText('<', fontSize: 32),
            ),
          ),
          const Expanded(
            child: Center(child: AppText('Battle Bots')),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
