import 'package:batlle_bots/blocs/game/game_bloc.dart';
import 'package:batlle_bots/game/player.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'game.dart';

class BattleBotsWorld extends World
    with HasGameRef<BattleBotsGame>, FlameBlocListenable<GameBloc, GameState> {
  BattleBotsWorld({required this.clientId});

  final String clientId;

  @override
  Future<void>? onLoad() {
    add(Player(clientId: '000'));
    return super.onLoad();
  }

  @override
  void onNewState(GameState state) {
    super.onNewState(state);
    BlocProvider.of<GameBloc>(gameRef.buildContext!)
        .state
        .clients
        .where((client) => client.id != clientId)
        .forEach((client) {
      if (client.isDeployed) {
        add(Player(clientId: client.id));
      }
    });
  }
}
