import 'package:batlle_bots/app/widgets/chat_textfield.dart';
import 'package:batlle_bots/app/widgets/widgets.dart';
import 'package:batlle_bots/blocs/chat/chat_bloc.dart';
import 'package:batlle_bots/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Container(
          height: 150,
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
              GestureDetector(
                onTap: () {
                  context
                      .read<ChatBloc>()
                      .add(ChatSubmitEvent(message: state.currentText));
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Container(
                  width: 100,
                  height: 50,
                  color: actionColor,
                  alignment: Alignment.center,
                  child: const AppText(
                    'Send',
                    color: blackColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
