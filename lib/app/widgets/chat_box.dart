import 'package:batlle_bots/app/app_barrel.dart';
import 'package:batlle_bots/blocs/chat/chat_bloc.dart';
import 'package:batlle_bots/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Container(
            color: buttonColor,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ListView.builder(
                      itemCount: state.chats.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: AppText(
                            'Player ${state.chats[index].sender}: ${state.chats[index].text}',
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    color: buttonColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
