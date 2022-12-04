import 'package:batlle_bots/app/app_barrel.dart';
import 'package:batlle_bots/app/widgets/lobby_button.dart';
import 'package:batlle_bots/app/widgets/text_spacer.dart';
import 'package:batlle_bots/blocs/chat/chat_bloc.dart';
import 'package:batlle_bots/blocs/game/game_bloc.dart';
import 'package:batlle_bots/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) => print('hello'),
      builder: (context, gameState) {
        return BlocBuilder<ChatBloc, ChatState>(
          builder: (context, chatState) {
            return Container(
              height: 400,
              color: buttonColor,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: ListView.builder(
                        itemCount: chatState.chats.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: AppText(
                                'Player ${chatState.chats[index].sender}: ${chatState.chats[index].text}',
                                fontSize: 12,
                                color: chatState.chats[index].color),
                          );
                        },
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 5,
                    color: accentColor,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      color: buttonColor,
                      child: Column(
                        children: [
                          AppText(
                            'Players online(${gameState.clients.length})',
                            fontSize: 16,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: LobbyButton(
                                  color: redColor,
                                  text: 'Host match',
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (gameState.client != null) {
                                      context.read<GameBloc>().add(
                                          GameDeployClient(
                                              client: gameState.client!));
                                      context.push('/Game');
                                    }
                                  },
                                  child: const LobbyButton(
                                    color: greenColor,
                                    text: 'Join match',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  TextSpacer(leading: 'wins', trailing: '0'),
                                  TextSpacer(leading: 'losses', trailing: '0'),
                                  TextSpacer(leading: 'draws', trailing: '0'),
                                  TextSpacer(leading: 'elo', trailing: '1000')
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
