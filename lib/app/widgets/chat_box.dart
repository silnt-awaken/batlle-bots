import 'package:batlle_bots/app/app_barrel.dart';
import 'package:batlle_bots/blocs/chat/chat_bloc.dart';
import 'package:batlle_bots/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Container(
            color: buttonColor,
            child: ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (context, index) {
                return AppText(state.chats[index].text);
              },
            ),
          );
        },
      ),
    );
  }
}
