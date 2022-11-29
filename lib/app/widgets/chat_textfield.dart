import 'package:batlle_bots/repositories/game_repository.dart';
import 'package:batlle_bots/styles/colors.dart';
import 'package:batlle_bots/styles/fonts.dart';
import 'package:flutter/material.dart';

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
    return TextField(
        controller: _controller,
        style: primaryTextStyle,
        cursorColor: whiteColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type a message',
          hintStyle: primaryTextStyle.copyWith(color: dullWhiteColor),
        ),
        onEditingComplete: () {
          // todo: send message from client channel to server
          GameRepository.channel.sink.add(_controller.text);
          _controller.clear();
        });
  }
}
