import 'package:batlle_bots/app/widgets/chat_textfield.dart';
import 'package:batlle_bots/app/widgets/widgets.dart';
import 'package:batlle_bots/styles/colors.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 100,
              color: buttonColor,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const ChatTextField(),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 100,
            height: 50,
            color: Colors.blue,
            alignment: Alignment.center,
            child: const AppText('Send'),
          ),
        ],
      ),
    );
  }
}
