import 'package:batlle_bots/blocs/game/game_bloc.dart';
import 'package:batlle_bots/game/player.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'game.dart';

class BattleBotsWorld extends World
    with HasGameRef<BattleBotsGame>, FlameBlocListenable<GameBloc, GameState> {
  // we need to see if there is a new state when the game has new clients

  BattleBotsWorld({super.children, required this.clientId});

  final String clientId;

  @override
  void onNewState(GameState state) {
    // TODO: implement onNewState
    super.onNewState(state);
    BlocProvider.of<GameBloc>(gameRef.buildContext!)
        .state
        .clients
        .where((client) => client.id != clientId)
        .forEach((client) {
      if (client.isDeployed) {
        // todo update server that client has been deployed. currently it is setting false because it is only set up for the local player
        add(Player(clientId: client.id, position: client.position));
      }
    });
  }
}
