import 'package:batlle_bots/game/behaviors/behaviors_barrel.dart';
import 'package:batlle_bots/game/game.dart';
import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';

class Player extends Entity with HasGameRef<BattleBotsGame>, EquatableMixin {
  Player({
    required this.clientId,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
    super.behaviors,
  });

  final String clientId;

  @override
  Future<void>? onLoad() async {
    debugMode = true;
    final image = gameRef.images.fromCache('player.png');
    final sprite = Sprite(image);
    await add(SpriteComponent(
        sprite: sprite,
        anchor: Anchor.center,
        size: Vector2(50, 50),
        position: position,
        priority: priority));
    return super.onLoad();
  }

  Player.none({
    required String clientId,
    required Vector2 position,
  }) : this(
          clientId: clientId,
          position: position,
          behaviors: [],
        );

  Player.arrows({
    required Vector2 center,
  }) : this._withKeys(
            center: center,
            upKey: LogicalKeyboardKey.arrowUp,
            downKey: LogicalKeyboardKey.arrowDown,
            leftKey: LogicalKeyboardKey.arrowLeft,
            rightKey: LogicalKeyboardKey.arrowRight,
            clientId: '',
            position: Vector2.zero());

  /// {@macro paddle}
  ///
  /// Uses WASD keys.
  Player.wasd({
    required Vector2 center,
    required String clientId,
    required Vector2 position,
  }) : this._withKeys(
          center: center,
          upKey: LogicalKeyboardKey.keyW,
          downKey: LogicalKeyboardKey.keyS,
          leftKey: LogicalKeyboardKey.keyA,
          rightKey: LogicalKeyboardKey.keyD,
          clientId: clientId,
          position: position,
        );

  Player._withKeys({
    required Vector2 center,
    required LogicalKeyboardKey upKey,
    required LogicalKeyboardKey downKey,
    required LogicalKeyboardKey leftKey,
    required LogicalKeyboardKey rightKey,
    required String clientId,
    required Vector2 position,
  }) : this(
            clientId: clientId,
            position: position,
            anchor: Anchor.center,
            behaviors: [
              KeyboardMovingBehavior(
                upKey: upKey,
                downKey: downKey,
                leftKey: leftKey,
                rightKey: rightKey,
              ),
            ]);

  @override
  List<Object?> get props => [clientId];
}
