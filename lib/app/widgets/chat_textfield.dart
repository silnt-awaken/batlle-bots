import 'package:batlle_bots/blocs/chat/chat_bloc.dart';
import 'package:batlle_bots/styles/colors.dart';
import 'package:batlle_bots/styles/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state.chatStatus == ChatStatus.submitted) {
          _controller.clear();
          context.read<ChatBloc>().add(ChatResetEvent());
        }
      },
      child: TextField(
        controller: _controller,
        style: primaryTextStyle.copyWith(height: 1.4),
        cursorColor: whiteColor,
        textAlignVertical: TextAlignVertical.center,
        cursorHeight: 30,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type a message',
          hintStyle: primaryTextStyle.copyWith(color: dullWhiteColor),
        ),
        onEditingComplete: () {
          context
              .read<ChatBloc>()
              .add(ChatSubmitEvent(message: _controller.text));
          _controller.clear();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: ((text) =>
            context.read<ChatBloc>().add(ChatUpdateTextEvent(text: text))),
      ),
    );
  }
}
