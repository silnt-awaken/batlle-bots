import 'package:batlle_bots/app/app_barrel.dart';
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
          playersList.clear();
          playersList.addAll([
            ...state.clients.map((client) {
              if (client.id == state.client!.id) {
                return Player.wasd(
                  center: client.position,
                  clientId: client.id,
                  position: client.position,
                );
              } else {
                if (client.isDeployed) {
                  return Player.none(
                    clientId: client.id,
                    position: client.position,
                  );
                } else {
                  return null;
                }
              }
            }).toList(),
          ]);
          noNullPlayers.clear();
          for (var element in playersList) {
            if (element != null) {
              noNullPlayers.add(element);
            }
          }
          players = noNullPlayers
              .where((client) => client.position != Vector2.zero())
              .toSet()
              .toList();
        }
      },
      builder: (context, state) {
        if (state.status == GameStatus.deploying) {
          return Scaffold(
            body: GameWidget.controlled(
              gameFactory: () => BattleBotsGame(
                  clientId: BlocProvider.of<GameBloc>(context).state.client!.id,
                  startPosition: BlocProvider.of<GameBloc>(context)
                      .state
                      .clients
                      .firstWhere((element) =>
                          element.id ==
                          BlocProvider.of<GameBloc>(context).state.client!.id)
                      .position),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: AppText('Setting up game...')),
          );
        }
      },
    );
  }

  final List<Player> noNullPlayers = [];
  final List<Player?> playersList = [];
  static Iterable<Player> players = [];
}
