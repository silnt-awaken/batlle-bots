import 'package:batlle_bots/game/player.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

/// {@template keyboard_moving_behavior}
/// A behavior that makes a paddle move up and down based on the user's
/// keyboard input.
/// {@endtemplate}
class KeyboardMovingBehavior extends Behavior<Player>
    with KeyboardHandler, HasGameRef {
  /// {@macro keyboard_moving_behavior}
  KeyboardMovingBehavior({
    this.speed = 100,
    required this.downKey,
    required this.upKey,
    required this.leftKey,
    required this.rightKey,
  });

  /// The up key.
  final LogicalKeyboardKey upKey;

  /// The down key.
  final LogicalKeyboardKey downKey;

  /// The left key.
  final LogicalKeyboardKey leftKey;

  /// The right key.
  final LogicalKeyboardKey rightKey;

  /// The speed at which the paddle moves.
  final double speed;

  final movement = Vector2.zero();
  double xInput = 0;
  double yInput = 0;

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    int xInput = 0;
    int yInput = 0;

    xInput += (keysPressed.contains(leftKey) ||
            keysPressed.contains(LogicalKeyboardKey.arrowLeft))
        ? -1
        : 0;
    xInput += (keysPressed.contains(rightKey) ||
            keysPressed.contains(LogicalKeyboardKey.arrowRight))
        ? 1
        : 0;

    yInput += (keysPressed.contains(upKey) ||
            keysPressed.contains(LogicalKeyboardKey.arrowUp))
        ? -1
        : 0;
    yInput += (keysPressed.contains(downKey) ||
            keysPressed.contains(LogicalKeyboardKey.arrowDown))
        ? 1
        : 0;

    movement
      ..setValues(xInput.toDouble(), yInput.toDouble())
      ..normalize();

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    parent.position.setValues(
      parent.position.x + movement.x * speed * dt,
      parent.position.y + movement.y * speed * dt,
    );
  }
}
