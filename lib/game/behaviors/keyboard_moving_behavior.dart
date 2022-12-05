import 'dart:convert';

import 'package:batlle_bots/blocs/player/player_bloc.dart';
import 'package:batlle_bots/game/game.dart';
import 'package:batlle_bots/game/player.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/repositories_barrel.dart';

/// {@template keyboard_moving_behavior}
/// A behavior that makes a paddle move up and down based on the user's
/// keyboard input.
/// {@endtemplate}
class KeyboardMovingBehavior extends Behavior<Player>
    with
        KeyboardHandler,
        HasGameRef<BattleBotsGame>,
        FlameBlocListenable<PlayerBloc, PlayerState> {
  /// {@macro keyboard_moving_behavior}
  KeyboardMovingBehavior({
    this.speed = 100,
    required this.downKey,
    required this.upKey,
    required this.leftKey,
    required this.rightKey,
  });

  late double deltaTime;

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
  final serverMovement = Vector2.zero();
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

    // for this to work multiplayer, I will have to send the parent's position, and the movement, and the server will
    // use this formula: parent.position += movement * speed * dt to return back to the client, to update the position

    final encodedString = json.encode({
      'type': 'move',
      'client': gameRef.clientId,
      'values_x': movement.x,
      'values_y': movement.y,
    });
    GameRepository.channel?.sink.add(encodedString.codeUnits);

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    super.update(dt);
    deltaTime = dt;
    parent.position.setValues(
      parent.position.x +
          (gameRef.buildContext
                      ?.read<PlayerBloc>()
                      .state
                      .severMovementPosition
                      .x ??
                  0) *
              speed *
              dt,
      parent.position.y +
          (gameRef.buildContext
                      ?.read<PlayerBloc>()
                      .state
                      .severMovementPosition
                      .y ??
                  0) *
              speed *
              dt,
    );
  }

  @override
  void onNewState(PlayerState state) {
    super.onNewState(state);
    parent.position.setValues(
        parent.position.x + state.severMovementPosition.x * speed * deltaTime,
        parent.position.y + state.severMovementPosition.y * speed * deltaTime);
  }
}
