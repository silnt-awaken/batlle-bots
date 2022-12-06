import 'package:batlle_bots/blocs/game/game_bloc.dart';
import 'package:batlle_bots/game/game.dart';
import 'package:batlle_bots/game/player.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameView extends StatelessWidget {
  GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        if (state.status == GameStatus.deploying) {
          context.read<GameBloc>().add(GameHandleDeployedState());
        }
      },
      builder: (context, state) {
        playersList.addAll([
          ...state.clients
              .map(
                (client) => client.id == state.client!.id
                    ? Player.wasd(
                        center: client.position,
                        clientId: client.id,
                        position: client.position,
                      )
                    : Player.none(
                        clientId: client.id,
                        position: client.position,
                      ),
              )
              .toList(),
        ]);
        players = playersList.toSet().toList();
        return Scaffold(
          body: GameWidget.controlled(
            gameFactory: () => BattleBotsGame(
                clientId: BlocProvider.of<GameBloc>(context).state.client!.id),
          ),
        );
      },
    );
  }

  final List<Player> playersList = [];
  static Iterable<Player> players = [];
}
