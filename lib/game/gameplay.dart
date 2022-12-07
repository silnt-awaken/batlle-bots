import 'dart:developer';

import 'package:batlle_bots/game/game.dart';
import 'package:batlle_bots/game/player.dart';
import 'package:batlle_bots/game/world.dart';
import 'package:flame/components.dart';

class Gameplay extends Component
    with HasGameRef<BattleBotsGame>, KeyboardHandler {
  static const routeName = 'gameplay';

  Gameplay({super.children});

  int resizeCounter = 0;

  @override
  void onChildrenChanged(Component child, ChildrenChangeType type) async {
    switch (type) {
      case ChildrenChangeType.added:
        if (child.runtimeType == Player) {
          if ((child as Player).clientId == gameRef.clientId) {
            gameRef.camera.followComponent(child);
          }
        }
        print(child);
        break;
      case ChildrenChangeType.removed:
        log('component removed');
        break;
      default:
        break;
    }
    super.onChildrenChanged(child, type);
  }

  @override
  void onGameResize(Vector2 size) {
    if (gameRef.isAttached && resizeCounter == 0) {
      final world =
          BattleBotsWorld(clientId: gameRef.clientId, children: children);

      addAll([world]);
      resizeCounter++;
    }
    super.onGameResize(size);
  }
}
