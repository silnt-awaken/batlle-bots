import 'package:batlle_bots/app/widgets/chat_header.dart';
import 'package:batlle_bots/app/widgets/chat_input.dart';
import 'package:batlle_bots/app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LobbyView extends StatelessWidget {
  const LobbyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: const [
        ChatHeader(),
        ChatBox(),
        ChatInput(),
      ],
    ));
  }
}
