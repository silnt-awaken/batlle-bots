import 'package:batlle_bots/blocs/game/game_bloc.dart';
import 'package:batlle_bots/game/world.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BattleBotsGame extends FlameGame {
  late final world;

  @override
  Future<void>? onLoad() async {
    // add image to game
    final image = await images.load('arena.png');
    final backgroundImage = Sprite(image);
    add(
      SpriteComponent(
        sprite: backgroundImage,
        size: Vector2(1200, 700),
      ),
    );

    await images.load('player.png');
    world = BattleBotsWorld();
  }

  @override
  void onAttach() {
    add(
      FlameBlocProvider<GameBloc, GameState>.value(
        value: BlocProvider.of<GameBloc>(buildContext!),
        children: [world],
      ),
    );
    super.onAttach();
  }
}
