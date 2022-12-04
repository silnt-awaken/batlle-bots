import 'package:batlle_bots/blocs/game/game_bloc.dart';
import 'package:batlle_bots/game/world.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BattleBotsGame extends FlameGame {
  late final BattleBotsWorld world;

  BattleBotsGame({super.children});

  @override
  Color backgroundColor() => const Color.fromARGB(0, 125, 61, 61);

  @override
  Future<void>? onLoad() async {
    await images.loadAll(<String>[
      'player.png',
      'arena.png',
    ]);

    final backgroundImage = Sprite(images.fromCache('arena.png'));
    add(
      SpriteComponent(
        sprite: backgroundImage,
        size: Vector2(1200, 700),
        priority: -1,
      ),
    );
  }

  @override
  void onAttach() async {
    world = BattleBotsWorld(
        children: children,
        clientId: BlocProvider.of<GameBloc>(buildContext!).state.client!.id);
    await add(
      FlameBlocProvider<GameBloc, GameState>.value(
        value: BlocProvider.of<GameBloc>(buildContext!),
        children: [world],
      ),
    );
    super.onAttach();
  }
}
