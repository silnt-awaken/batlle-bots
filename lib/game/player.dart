import 'package:batlle_bots/game/entity.dart';
import 'package:batlle_bots/game/game.dart';
import 'package:flame/components.dart';

class Player extends Entity with HasGameRef<BattleBotsGame> {
  Player({
    required this.clientId,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.nativeAngle,
    super.anchor,
    super.children,
    super.priority,
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
        size: Vector2(100, 100),
        position: position));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    print(position);
    position.x += 5 * dt;
    position.y += 5 * dt;
  }
}
