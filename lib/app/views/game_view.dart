import 'package:batlle_bots/blocs/game/game_bloc.dart';
import 'package:batlle_bots/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        if (state.status == GameStatus.deploying) {
          context.read<GameBloc>().add(GameHandleDeployedState());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: GameWidget.controlled(
            gameFactory: () => BattleBotsGame(
                // children: state.clients
                //     .map(
                //       (client) => Player(
                //         clientId: client.id,
                //       ),
                //     )
                //     .toList(),
                ),
          ),
        );
      },
    );
  }
}
