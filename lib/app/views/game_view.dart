import 'package:batlle_bots/blocs/game/game_bloc.dart';
import 'package:batlle_bots/game/game.dart';
import 'package:batlle_bots/game/player.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Scaffold(
          body: GameWidget.controlled(
            gameFactory: () => BattleBotsGame(
              children: state.clients
                  .map(
                    (client) => Player(
                      clientId: client.id,
                      position: Vector2(
                        100 + 100 * state.clients.indexOf(client).toDouble(),
                        100 + 100 * state.clients.indexOf(client).toDouble(),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
