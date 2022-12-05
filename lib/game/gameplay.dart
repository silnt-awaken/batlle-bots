import 'dart:developer';

import 'package:batlle_bots/blocs/game/game_bloc.dart';
import 'package:batlle_bots/game/game.dart';
import 'package:batlle_bots/game/player.dart';
import 'package:batlle_bots/game/world.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Gameplay extends Component
    with HasGameRef<BattleBotsGame>, KeyboardHandler {
  static const routeName = 'gameplay';

  Gameplay({super.children});

  @override
  void onChildrenChanged(Component child, ChildrenChangeType type) async {
    switch (type) {
      case ChildrenChangeType.added:
        if (child.runtimeType == Player) {
          gameRef.camera.followComponent(child as Player);
        }
        break;
      case ChildrenChangeType.removed:
        log('component removed');
        break;
    }
    super.onChildrenChanged(child, type);
  }

  @override
  void onGameResize(Vector2 size) {
    if (gameRef.isAttached) {
      final world = BattleBotsWorld(
          clientId: gameRef.buildContext!.read<GameBloc>().state.client!.id,
          children: children);

      addAll([world]);
    }
    super.onGameResize(size);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.escape)) {
      if (gameRef.paused) {
        gameRef.resumeEngine();
      } else {
        gameRef.pauseEngine();
      }
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
