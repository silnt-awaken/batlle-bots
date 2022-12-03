import 'package:batlle_bots/blocs/game/game_bloc.dart';
import 'package:flame/experimental.dart';
import 'package:flame_bloc/flame_bloc.dart';

class BattleBotsWorld extends World
    with FlameBlocListenable<GameBloc, GameState> {
  // we need to see if there is a new state when the game has new clients

  @override
  void onNewState(GameState state) {
    super.onNewState(state);
    print('hello world');
  }
}
